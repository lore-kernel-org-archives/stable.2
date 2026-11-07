Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051024;
	b=Qeza8+qXE2P3eXvDBcOnmTwgwOWtpgywQQJQs4pCT9OLJUMoK/A/rN1gE/zPeTWCMX98
	 5JPSWEshzAJiZerDXXlii2Gn4OSBbdXb78Dr9/uTmd8+oVoDkNP8ZPJy+GMTmuZNVk9o/
	 frMEP0gofTRHHtT6hlzpvNtjKfFkTeFY1uvQoJavydgfcVV7VkrOhamR7NN5V6ecC0GxH
	 Z0B2nAbhWwzGpV3ismKS4VImyQ1JoqqWqTNr4rA9NrB/l/UwuKC2HDvtfnftxm9+EUBt+
	 L3Xtj4PWK6yrL0RfARnuBJSnSme94TxoHlaL34GCo+H5eg39qjs9+mWX/nEfMcufCCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051024;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=B0d9g/+lGYQK6jyBcmR5fyn8sKYpa9p998xUzqIr6qk=;
	b=bstcqpW2+XavTvN5l6HaSYN/dakEcCpe4bkZkBS7PxrLtsOpV6BJddq8zFJTGsBFckkg
	 8Y0hlDxqR2F+VmAOkjUrXsN3508uV9CAzJtImZmN/VwGNtbSq2L9Yx7/vhMkTRa8dTPLt
	 XT+ov5KnlySmUGi/QCpwBywNRG0vxEIsvogbioHtOO3WJZ+TP36FNB9hSUyw9iH+86NzW
	 xnQX6ErLRSO2VyqWQENiKLylw97VEFRN8hKcNgnEw3XFdLijcyDF7Gbxyl8CCulO0qVfA
	 ffH+9Ab9YCCbz09UmWdfxIgjoiUmp54FtFWeJhql2JXGzK3Z2fzp2Prnc8+KI6egH8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7bCZS+X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57549606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7bCZS+X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A1F1F0089F;
	Sat,  7 Nov 2026 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051024;
	bh=B0d9g/+lGYQK6jyBcmR5fyn8sKYpa9p998xUzqIr6qk=;
	h=From:To:Cc:Subject:Date;
	b=D7bCZS+XHPoMF6K2D7IXPuvyZWZEAhollbNvpEaMSzTJ2l4OZloYBl3AIPIlSn01+
	 iArebhWK7j5zQ+r1cIH7fC4e88kKpHV5VrjCCnHLn7AT/luGFhZWwZ76OoMrxzRmfo
	 5YxXZKjUC3Z4ajpDM4VwkTulfD67nlqVHS44XCqeCO81mDZW18Z68o8+gsFAGsTUS+
	 9gAnMNERZ7gh/TXlQAOZ4MROGDt6b/v4qyk1vwGiU67MV2kPRGSbeC0i/e1EPJCq+w
	 FCXLL/ScgVlJ1xhv2DH8/5lI77noQkTwZDJD1QQBXYPOZCHJE65ek9E9Vxz8Q/+P2L
	 qhcKEYxw51NCQ==
From: Sasha Levin <sashal@kernel.org>
To: kanie@linux.alibaba.com,
	dwagner@suse.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvmet-fc: Tear down the association when the admin queue allocation fails" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:30:22 -0500
Message-ID: <20261107063022-failed-5.10-11db8ab55e1a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 11db8ab55e1a7533e9cfe57687ab142ba67d3c84
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107063022-failed-5.10-11db8ab55e1a@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 11db8ab55e1a7533e9cfe57687ab142ba67d3c84 Mon Sep 17 00:00:00 2001
From: Guixin Liu <kanie@linux.alibaba.com>
Date: Mon, 26 Oct 2026 18:44:56 +0800
Subject: [PATCH] nvmet-fc: Tear down the association when the admin queue
 allocation fails

When the initial admin queue allocation fails after a new association
was created, nvmet_fc_ls_create_association() only drops the
association reference, which frees the association.  By then the
association is already on the target port's assoc_list, though, and
removal from that list only happens in nvmet_fc_delete_target_assoc(),
which this error path never calls.  The freed association stays on the
list, where later lookups and the port teardown can access it, and the
target port reference taken at allocation time leaks.

A remote host can trigger this reliably with a Create Association LS
requesting a queue too large to allocate.

Schedule the regular association teardown instead of dropping the
reference directly.  The teardown removes the association from the
list and releases the target port reference before the final reference
drop frees it.

Fixes: 0cab4404874f ("nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association")
Cc: stable@vger.kernel.org
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a63ffb436a928..2b7dc3f03912d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1708,7 +1708,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 					be16_to_cpu(rqst->assoc_cmd.sqsize));
 			if (!queue) {
 				ret = VERR_QUEUE_ALLOC_FAIL;
-				nvmet_fc_tgt_a_put(iod->assoc);
+				nvmet_fc_schedule_delete_assoc(iod->assoc);
 			}
 		}
 	}
-- 
2.53.0




