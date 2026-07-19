Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F32D5926
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784463250; cv=none; b=oqfDlgRsqLaY6/rNNBXLfWJfbBvGBN66ojQS246ONFAJioD65LSQtDJ6JIKzq50rhusGddVDhuAWnjA56oNr9IYwyW1t6VsUDAybpQ4vf381Oav9L8CCEnrx/9nfgQ/5Eff8XaSoRb2zki2cDemMqmTOIY66TWoG4CP1ClgIlU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784463250; c=relaxed/simple;
	bh=0poANyyyf0gx087A8y2wdbMP3riVXsqCI2HgVHK6CMY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SaZ6fAQFOffoG6DkS3otYohTZZhFK3WwIOZ19rDE+7ZbWJjz46LpXG0lzElZJo/+Op/EABS1S0kC3AJdiUFUt7c3Q1MsaoJxKMFfqpM7auwYKj7NbVw6frzxXtbdNAfCJosBKpfe+WaDjpGkXtn7r0PR9mi3VuxyPtujX5QAV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EhacJNok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EhacJNok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C9B1F000E9;
	Sun, 19 Jul 2026 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784463249;
	bh=20KalCuFlRGsiEScVoBIan1YldIEb4lfVNdn6v0vHF0=;
	h=Subject:To:Cc:From:Date;
	b=EhacJNokdP/aVahGKtQ+FQQD/fnGiKnw8v45FieC8s+j5OSdQeSlKAwcw4Cxic/0x
	 Yww2PUXuq2/seg9N4x9cIW4JPgP+56cEhXwo8itqvB4g/3Vv+92mnSjs4TBm1aPF7D
	 jCt0NWUiS+KE4tnEfaj4+jgUkGILqL5QAOhliMTY=
Subject: FAILED: patch "[PATCH] nvmet-tcp: Fix potential UAF when ddgst mismatch" failed to apply to 5.10-stable tree
To: sagi@grimberg.me,hch@lst.de,kbusch@kernel.org,kumar.shivam43666@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 19 Jul 2026 14:14:00 +0200
Message-ID: <2026071900-poster-swear-030a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x dbbd07d0a7020b80f6a7028e561908f7b83b3d5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071900-poster-swear-030a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dbbd07d0a7020b80f6a7028e561908f7b83b3d5a Mon Sep 17 00:00:00 2001
From: Sagi Grimberg <sagi@grimberg.me>
Date: Sun, 10 May 2026 23:30:29 +0300
Subject: [PATCH] nvmet-tcp: Fix potential UAF when ddgst mismatch
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Shivam Kumar found via vulnerability testing:
When data digest is enabled on an NVMe/TCP connection and a digest
mismatch occurs on a non-final H2C_DATA PDU during an R2T-based
data transfer, the digest error handler in nvmet_tcp_try_recv_ddgst()
calls nvmet_req_uninit() — which performs percpu_ref_put() on the
submission queue — but does NOT mark the command as completed. It
does not set cqe->status, does not modify rbytes_done, and does not
clear any flag. When the subsequent fatal error triggers queue
teardown, nvmet_tcp_uninit_data_in_cmds() iterates all commands,
checks nvmet_tcp_need_data_in() for each one, and finds that the
already-uninited command still appears to need data (because
rbytes_done < transfer_len and cqe->status == 0). It therefore calls
nvmet_req_uninit() a second time on the same command — a double
percpu_ref_put against a single percpu_ref_get.

Reported-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 164a564ba3b4..20f150d17a96 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1321,8 +1321,10 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			queue->idx, cmd->req.cmd->common.command_id,
 			queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_ddgst),
 			le32_to_cpu(cmd->exp_ddgst));
-		if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED)) {
+			cmd->req.cqe->status = NVME_SC_CMD_SEQ_ERROR;
 			nvmet_req_uninit(&cmd->req);
+		}
 		nvmet_tcp_free_cmd_buffers(cmd);
 		ret = -EPROTO;
 		goto out;

