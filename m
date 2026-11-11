Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794437193;
	b=OhCVy90zxLG6iUglZlAkOuV0tS5Nd7TjBzYsw9tEKb/KBS1Dl4g8TVGwRar1YkOW7Ox3
	 2IfO8tud/UGIosLwBrWM9JAynlMaLRtGmWYMLB/6XZx5lLUK4IVf6D4prYXbCHAvwkHGp
	 Pwe9cj92lQh8ngwBEgOYwhzMsbVz0ec8Bo1qJi4U/lnMGluoAeZzy1ptO+csHpRMYuS+9
	 l6us4Y9l+6+S7FHUgmnGnWGFJzs1PQfNHm5nQF75dJEt+ibAxEL9/m0LuoUwL73lZmhO6
	 AckCi9NJ8qn/xY3ditBvpNqUZM+Wo7tfDko+hrjp49CcfrJuejW58iR7uwGdfxt/VoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437193;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AjpfbymZu8Tt2ID8CSknEr5GE1ZOsi7uzDe6VqE3cqM=;
	b=zztW3vt+nMVq2pMtijEDsGD2teuH3GmNW7LFeQ280lGhv/k7aqLP10q106o+FR9Fl/HH
	 VE5Z1ODYer4NWWHO5N8hMCSejfKsoZWYaeZ+Smr0ablrT7Wi6gLVfHj/Kk7QzGAeQADt7
	 HBb519AbZwDNXDw/gcCFFA9hplaNGmHPkgUhKst2TbG0witDY88YcoTI80AhjQwFsrRm6
	 h9jEyGEJHopQp4ns1eWvbKjBYgvCfUU3oBbAMPbObSNT+feLMioWF1Bf3WcxMv3tvlVzy
	 BSTWVgW67Yzkfpt+815xrVNMJ0koCnznAzBGB2K6+AYtGjFw9t7cu5T5J3LAD+aJU+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAsmaNuH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78443606B00A;
	Wed, 11 Nov 2026 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAsmaNuH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794437193;
	b=OtQuJtYL7wxYk39Gz8k7KG77ZXcNtq4EHliFCRSrBoNf60IPOuP3M0FoetDHBWDGAhwU
	 5u/cB3sqshlotm1apJorwi4UsF7bYhaXrWJbx+YlCW0Q8qkHBod2hswTC5pq4hLALNv9E
	 PN8a5u09y76FChoqgC2cKa+6N3HzGkDvWooV43xGb2/yu2JevKhhc/PvRNFJsjI6kRyX+
	 RMvXQAd5dFUi4Q/dEkrnxUhVbw7EuPqgMEI3GeufLx+Bqx1CuPSe71OVTmAYjEP7RrnJQ
	 9NKbPC1MUHxb8PEkaLKMSolDk7cKRMibffKhwy48wfMkFo1KCE4qFbdMT9SWtluJsKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794437193;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AjpfbymZu8Tt2ID8CSknEr5GE1ZOsi7uzDe6VqE3cqM=;
	b=dDHEwt1LSwyRNrvy6vq8FzgPu4U8ZbMX2d3x2niX1B5WRLOUV02SHLbxDyGLPlP2eTKO
	 W6ZnTqRgnVxg+ZNL6QAXwybgvA1HHwl0z3O7e4ifHeDrwubOQR2tVgBgeQ7vTNgu9JcPL
	 +cTXeHA7p+62+wSe3mZhHIc4v5MA/mTZ8MuZg0GEV940kwuaDEJ9fori2oR8vD05nfP35
	 j1nyHo+W7np1VzZOHs4vQ6x/4w1vBmW/Xl+AIhKXvXYMQsDRF75ec6uHncluG+AK/OFs0
	 MsRrGyqawE7zwuWKH1A5wASX/OjD9VMD7OjU2Um7bMOIPdp/IU0P19j8nb9ATSHOPrA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 467611F00A08;
	Wed, 11 Nov 2026 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437193;
	bh=AjpfbymZu8Tt2ID8CSknEr5GE1ZOsi7uzDe6VqE3cqM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=GAsmaNuHZ9pShJbdgZGHi61EKqFk3NQRTm04Xm/62F3DGx1wfJmIdTFQrju2c/uyX
	 J+lnG9EmIZ1xrA9FgqyEzNRoB94t+aokFvy+R+eHEm/09MsgbUTebcjEoFfWBcDewj
	 NJuONisTmNalqZyuB9X4vMGHvrE3eTQutFP2oSTqu+yiM/QWQBjv15OrN++blwO5KB
	 g3LdOd0/ePhd+RjaoYO+A8cPAA7GJyrECwJJiQJDMHggL8LLSWF4MVuCXs49TpqaQC
	 vJxNPPxRIgleG4/YLzkmyUFlks2xoiyQ4O2z/ARAkvtT5CMdX8dJqPF+QuJVVR0iyS
	 7V+QgCm0pB5eQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8DC7C49139;
	Wed, 11 Nov 2026 22:46:31 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Wed, 11 Nov 2026 17:46:31 -0500
Subject: [PATCH] nvme: fix deadlock on nvme_subsystems_lock in
 nvme_init_subsystem()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-nvme-subsys-lock-deadlock-v1-1-1837b8e9076f@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw7CMAwFr1J5jaU2Aiq4CmIR4kdrPimKoQJVv
 TumvNWbxcxEhqIw2lcTFYxqOmSHZlVR6mPuwCrOFOqwbXycxzvYXif7GN+GdGVBlOW06wCBiGx
 2kdx/FJz1vbQPxz+7d0F6/oI0z1+LO4dAfQAAAA==
X-Change-ID: 20261111-nvme-subsys-lock-deadlock-742ededdd59a
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794437191; l=2940;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=cOZLSGE+OmO3+XZiW2AyMoXiLb0mQ0fDaQF1JNZtd3I=;
 b=DFCsz9vJwyVkdjRUdcJS1+RgfZoeSSZgklxln7oPkWlolfNySJO2nXIEmKzRhVDzA1zS+lXKZ
 M3QEdsuQ0g2BRHGDCojYiG0FWbXULh3Y8n+Fdf2bPkfZM6ohEJRIE1B
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

Connecting a controller to a new subsystem deadlocks when
sysfs_create_link() fails in nvme_init_subsystem(), e.g., on an
allocation failure.  The error path drops the last subsystem reference
with nvme_subsystems_lock held and nvme_destroy_subsystem() takes the
same lock again:

  nvme nvme0: failed to create sysfs link from subsystem.
  ============================================
  WARNING: possible recursive locking detected
  ...
  nvmesubsys/95 is trying to acquire lock:
  (nvme_subsystems_lock){+.+.}-{4:4}, at: nvme_destroy_subsystem+0x1b/0x1e0

  but task is already holding lock:
  (nvme_subsystems_lock){+.+.}-{4:4}, at: nvme_init_identify+0x81e/0x34b0
  ...
  Call Trace:
   __mutex_lock+0x1a2/0x26e0
   nvme_destroy_subsystem+0x1b/0x1e0
   nvme_init_identify.cold+0x3bc/0x56f
   nvme_init_ctrl_finish+0x1bc/0x7a0
   nvme_loop_configure_admin_queue+0x205/0x2b0
   nvme_loop_create_ctrl+0x480/0xd10
   nvmf_dev_write+0x365/0x650
   vfs_write+0x1e3/0x1250
   ksys_write+0xfa/0x200
   do_syscall_64+0xfb/0x590
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  ...
  INFO: task nvmesubsys:95 blocked for more than 20 seconds.
  INFO: task nvmesubsys:95 is blocked on a mutex likely owned by task nvmesubsys:95.

Every later controller setup or removal then waits for the lock too.
The nvme_validate_cntlid() error path for an existing subsystem does the
same put, and deadlocks the same way if the other references go away in
between.

Drop the lock before the put.  For a new subsystem, take it off the list
first so another controller can't find it in between.  With the fix,
the connect fails and the next connect works.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 30s.

Fixes: 32fd90c40768 ("nvme: change locking for the per-subsystem controller list")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/nvmesubsys.c

It uses nvme-loop and fault injection to fail the sysfs link.
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd0df9b03806..f43582e5f6c4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3413,7 +3413,11 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return 0;
 
 out_put_subsystem:
+	if (!found)
+		list_del_init(&subsys->entry);
+	mutex_unlock(&nvme_subsystems_lock);
 	nvme_put_subsystem(subsys);
+	return ret;
 out_unlock:
 	mutex_unlock(&nvme_subsystems_lock);
 	return ret;

---
base-commit: f92fe8dea19c743eb9e4d998ae0384344dd40091
change-id: 20261111-nvme-subsys-lock-deadlock-742ededdd59a

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


