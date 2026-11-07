Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047394;
	b=fosvRO/1ZMK0c/8ZDIAbtqbNRM1XQVr+1XAYPQhuVDv7pZzSf5TF1crDH3wMoseFrfuf
	 kgUZnIy46INnMLfrP/yI1dHI/s1n0lNRFT8SW3IO/W324DBMn2s2tBK/dP3rJxs1oXIvS
	 UQOFbDpOQCTezSfcVAL7kz22gag00OsEhg3nvPXm6qLalAO6DLR99lOf4tBUBegyeEVu9
	 W8ziHWxNpVJ2nK2GczYEwgr9lzbT1Z7IITyyDcALj78Q9GHfN4ydM3PJiC8w3pbD7zK+F
	 vnV1uhm2EaYz81aqJtu7sOstS0uf216u2tWzKCrGQusCwJXwxqeKrPwRUV9X95HTWHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047394;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XxNYb5RRlGqr41QdBjbZOuNcRq34oTnMUYCKcOLq4wM=;
	b=3IbdVHllUSG9DmX9L7HQgREDdPQJpZTEGL77XWnfpwPk1L8w9b9b4s2O33jVqNt0acs0
	 lMVZD2bhDv8hkDF4ds6lBotxsEl1W2O3B7RPZAsDMTCVQU/bDX0dsjjk+pCHmk980EsIG
	 aULYBEFNh5LGJif6hhVs1Wae1VrJRD0rvbzf9DnKk+cVXqgdpNXuIn3qKT73S4/ds5Y98
	 rbnsyAFXKHOj7RmC1QajqBW7TeiKPbGMEwacx26Wa+2/4ub6T2/iomneQSGUcLlXBcxt3
	 J3YeA0acG97W3CCxFuF4VFq+831WqgNjdsltRMovwMU4FOlNW81xvS9tMtL8u9ecAtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVmM9YsZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B381606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVmM9YsZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861431F0089F;
	Sat,  7 Nov 2026 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047394;
	bh=XxNYb5RRlGqr41QdBjbZOuNcRq34oTnMUYCKcOLq4wM=;
	h=From:To:Cc:Subject:Date;
	b=ZVmM9YsZ+Cwu9pyVsz6aDr+gKApO/HV2JuddEM839rViylQlJX0MKUaxXS6FB2HVb
	 eBl7ocLEvS1nUJaCFjPm065wtROuOGSWB3+nRGd29zzhU9MNkPaNiih2uqcPLDfX4o
	 HWFPWk1yrjTGZ+K4kOnH7HyWRoj5+k2zl269j+iwpc3Z0ljWoWxWmf4fxQLXlqrMB3
	 WGDaX/7bjHNkrfVHMfWz+pyeCE2Ps4tLS7Cyi1DGwiCsjAEmxeFymNwmZpeo5pKGlq
	 cd0jZSZNzVxkXNGzquO15GL6VIBGhie/+rPaUlBmg08PPM6DQ7lG2FM4zdWd+L5Q8/
	 KjrhDblaKY0tw==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: serial_ir: Fix race condition where timer can be re-armed" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:52 -0500
Message-ID: <20261107052952-failed-6.6-d74ac4016ba6@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d74ac4016ba64cb3b20f395511d0b18025ca0ba9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052952-failed-6.6-d74ac4016ba6@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d74ac4016ba64cb3b20f395511d0b18025ca0ba9 Mon Sep 17 00:00:00 2001
From: Sean Young <sean@mess.org>
Date: Tue, 1 Sep 2026 16:20:18 +0100
Subject: [PATCH] media: serial_ir: Fix race condition where timer can be
 re-armed

Ensure the timer cannot be re-armed.

Fixes: 2940c7e49775 ("[media] serial_ir: generate timeout")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/rc/serial_ir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index 992fff82b5245..f6702b3df9a03 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -798,7 +798,7 @@ static int __init serial_ir_init_module(void)
 
 static void __exit serial_ir_exit_module(void)
 {
-	timer_delete_sync(&serial_ir.timeout_timer);
+	timer_shutdown_sync(&serial_ir.timeout_timer);
 	serial_ir_exit();
 }
 
-- 
2.53.0




