Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426629;
	b=l3BWByC6SHH3r1kJJhTshZ/SwDts3rKSAsLuspD9kM8tT6SePz+SFAB+qjh3IcT5xEi5
	 KdxsEFHmEVTPnM6RDxxspRBPucf9VVVnj+6LBJQmzOmM1aXflRsQKZQmPMRyyObT1V2VG
	 /DBBev8Dmd8UHteGoSf2RmKWEkgUiiKHmwzVyGGz3pv/Ljo8FdySzimzN0fYf/b7Jxfn/
	 RMRMJ8XTAzOsM4AO8CUUW0bUs64lvWmQDXKQGJuf1S6IAq1K8iCCMV2HxVSSSL09uONaS
	 dnxbwzDoRkw1/J8LjnWTllVbnkPmuq5/0fEHxJY4Hldq7zGzDLQ/7Wqv/5kLWPzy2zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426629;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e8j+vJi7a1RZrwGdpuesKoOlk5QkbQ25o0NvLGByxdc=;
	b=XecEtDxV0vJVEM58639vf6mQNKtz3w4SR0uVREdnfdTqduJHkU2CXcbbKNTffHby6JY0
	 sygrH1PBaSzelWaLK5sfAmHiT60brYBTttuAsjkdQ05tO64C9sTHLwLAo4TdVyIAFpIn6
	 KUT5UYtHWa8C0P+76QHMG1IBeHCevFCLpk1NBlGNMfOkNZJcLpA8Zykrpx1JLoidSOrtP
	 QJkF+ialzlM907iLdAusSiAuFgdTJAECLb7lzR9w1Oqr1fhUFkmyl5mQay7JRqPqWTWlb
	 9g458gRTdJGr/q5x+mnheU/AuL+A6c8Smv5XbCt6XxPj32d5Al2vwf2nsRXVPzB5fhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzc+fLGc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA8D606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzc+fLGc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CD31F00A06;
	Wed, 11 Nov 2026 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426629;
	bh=e8j+vJi7a1RZrwGdpuesKoOlk5QkbQ25o0NvLGByxdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lzc+fLGcYYEg+J1bX+rAOj/uZjlpf9/5W8sFyMe5Yc2B6IOq74wEkZsjfE1GCuFUo
	 W0SsLUUPkNZqfdBBg/zU8T7sH12uh0KAGypWdh++If9Ahr5Qe5uD1Sa63ujs7uwlFT
	 ySi08+bASJ1yEcQT+raR/NDK0TRkgPRj1LZgHGaKufI6W6pLhLTp4tde+dapfkGH+E
	 wmjaJGTxCS3N9UpfKxckmYSA9sG+GvXnI22RfXSTSLFhVjacQb/YEzVGMzrFyIFNiA
	 GsdREQCwLsEfsTlJI0jc52DxD0evtatKdxD/Ol1kyfPSfs7+FXchITEyyoRSrhlofT
	 vwdcP5TJGOWHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] pidfs: prepare to drop exit_info pointer
Date: Wed, 11 Nov 2026 14:50:26 -0500
Message-ID: <20261111194945.4005899-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051552-failed-6.18-172658cf6009@kernel.org>
References: <20261107051552-failed-6.18-172658cf6009@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit ad6e3ea683ef4086cdf3d2ec40cb3f6e62edb945 ]

There will likely be more info that we need to store in struct
pidfs_attr. We need to make sure that some of the information such as
exit info or coredump info that consists of multiple bits is either
available completely or not at all, but never partially. Currently we
use a pointer that we assign to. That doesn't scale. We can't waste a
pointer for each mulit-part information struct we want to expose. Use a
bitmask instead.

Link: https://patch.msgid.link/20251028-work-coredump-signal-v1-6-ca449b7b7aa0@kernel.org
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 172658cf6009 ("pidfs: don't let PIDFD_GET_INFO miss a reaped task")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pidfs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 4341492b91e12..d2afc85b9df37 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -49,7 +49,12 @@ struct pidfs_exit_info {
 	__u32 coredump_mask;
 };
 
+enum pidfs_attr_mask_bits {
+	PIDFS_ATTR_BIT_EXIT	= 0,
+};
+
 struct pidfs_attr {
+	unsigned long attr_mask;
 	struct simple_xattrs *xattrs;
 	struct pidfs_exit_info __pei;
 	struct pidfs_exit_info *exit_info;
@@ -325,8 +330,8 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 
 	attr = READ_ONCE(pid->attr);
 	if (mask & PIDFD_INFO_EXIT) {
-		exit_info = READ_ONCE(attr->exit_info);
-		if (exit_info) {
+		if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask)) {
+			smp_rmb();
 			kinfo.mask |= PIDFD_INFO_EXIT;
 #ifdef CONFIG_CGROUPS
 			kinfo.cgroupid = exit_info->cgroupid;
@@ -681,7 +686,8 @@ void pidfs_exit(struct task_struct *tsk)
 	exit_info->exit_code = tsk->exit_code;
 
 	/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
-	smp_store_release(&attr->exit_info, &attr->__pei);
+	smp_wmb();
+	set_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask);
 }
 
 #ifdef CONFIG_COREDUMP
-- 
2.53.0

