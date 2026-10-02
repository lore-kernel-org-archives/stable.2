Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64294CEE45
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958665; cv=none; b=P7X1miS3/3I/Ch1NZBWU0zYVtlgt+PX0D1vW4HCrVA2iBh+Eo496w6+SPZw56/2kGErNrfqN5+GlOqkQ9uRIf7rp4gHxAMtAi6psj78ZtlbwpIK/HjvG7FBTmtTcCv00OUx3IWMEPL9uR1PIaMVcRJvaBAlF5dgxFLJGATRXFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958665; c=relaxed/simple;
	bh=jAVyoPFOGoJNDUPNicqFhPI6X+mwoNpniDinA5jjIKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3hhYswbHsczc4Rs7Ai8HHOjdbZM9VM5KAiv9C4MMVyl4LjNiy39Eu4fo8uFwXcAu+pkmqG3Lod6KKnVAuO7503qMorxSzdchTzwhYCbSYP7ngWfveSJc3BVMl38mh4tm8SWTj+6HPK5Y9GgKHgHxk38Voih+ydtDOIgRC2PKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=psr15Rg7; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psr15Rg7"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7cc70890fso1992638a12.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790958663; x=1791563463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IaFagpghjtV9+3wZXz2ZSUNu1qs1ItHjvm01FGweyZ4=;
        b=psr15Rg7NIOOlcvMgxTi1QlrabGw0v1c/4cOPBt4PVzieNG25MzmgzeESZMaSDCe1y
         wde13bCosSOfxp0ZBX9WuyFaG5WZwwsD2wDeXa1jDc49tejfUjM3LFos8qXGNhagbZE9
         aBT0ES2GdbWsPKf4YY9Tef8/Obg/urNO71cmyv6MfJSvaHplazpv3aTLDhGTE455Nghg
         Y2+gjkd9rJahRnMmaCSZ54toOhd6tlir5OdK1pRaLiZbKwt0j3y138vR3SEyjGj/mUxr
         u0pxekJpThZP7p93NnNeDiaLf4ys5vaIfo00IchWG+HUgHnEl4g2tPgdZRhXMkLq1UoQ
         Hbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790958663; x=1791563463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IaFagpghjtV9+3wZXz2ZSUNu1qs1ItHjvm01FGweyZ4=;
        b=eGaaTGiFx3jJUnaEWIwRwU7bHitqZ7XYqz4KD3kFR6cVfcoVdK35BryjvjBBJVS/8p
         DmP/ZuXG/Gu1nFR76SNYYh6KM+nvwp/xiUZMP0YygtI8/nmTkPzLPVbUaS+y2h5vD3xt
         RrsHPoku4tGPXEOIIdMlnOXvFccR8X+gHbAqjYMdSr/1/j2TmHfW6zOHshVI7W7lGeiI
         WB1eWLFwNx1+zqM6ZI1Ek5elVeStBy/UMrvF4DYT5ksejTeahfErfODPsBjfr2ViWMKx
         /LeSmR4fjxYZvkEX3MbQflsQ9PZ1O1VrHcxG2m6htDWV423u7DGjaWTsZQfrgAca/UEv
         fKkg==
X-Forwarded-Encrypted: i=1; AKwUvBza5PJ/9NN5sPGqE7n+/IAph8yHmoCfC4SxvO8ykz+4d7jA9NeTyzIrsh34HuE2KaWtjAMGm4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKh3M+jsn86b75peZadFtYJQQx9+62ikQSt4hqQstqcgqh/X9k
	ISNYNRaagOTHjhGuM9XZdWD0ZYzoX9F9xKD5WFw7/O176ngaJZhqSIMt
X-Gm-Gg: AYBFou2STCqwxcOTcg6niZp3Gh8I8VtcSTtMYenh+nj5Y955YSce5sF+HCZsMu4982G
	3qEEox7T4zTM6accT8NxLnNlTBJoI7PIEcIf/e4NN1SxN9LyVgfxYKG27yMqPUUPe2YzEoWqWgM
	4E4/2iegwIEd43CtJ3kp+LSORf4CGlDv1PJOvjkabNRfIHB6K9JMrzdmqxMGMRsJuIsy6UNOX05
	e0Zkfm5D2dL2X4+iFB0CoQLhS+FphLBApKcsY8bceXUhlfUENKKSGmH9ifbYX/mATr9MudDXENt
	dFxzKny2VZ8jvo5nxR/w7NWC6Ev4kXhM1IeypBl/lwvNj7MaRa6jlA5eL9rgNWzLtUGzB/ZmfBT
	I2ou/AYsZnF0dYdqtbDdSVx9YXhTQC1eIxCN9hkv+twZo4fa1dhhVsTyx/AqUuZQOvMYTOXN1z2
	f04dZAxUrCM9EHMIiwA7VzQVPrTBaVZH/6wOcpTmdX4ONZbFZJxGCcR2hLWEARzBbLwVR9Vg==
X-Received: by 2002:a17:90b:5687:b0:3a4:cbc4:4a98 with SMTP id 98e67ed59e1d1-3a6cec878e2mr3192049a91.64.1790958662555;
        Fri, 02 Oct 2026 09:31:02 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7aa0:50::3cf:1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f4747100sm9483860a91.11.2026.10.02.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:31:01 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+76c0f0ce8f1e846b4f84@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org
Subject: [PATCH] nvme: keep the effects log per namespace path, not in the shared head
Date: Fri,  2 Oct 2026 23:30:56 +0700
Message-ID: <20261002163056.48708-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6abf0753.eb639fcc.2b981.0008.GAE@google.com>
References: <6abf0753.eb639fcc.2b981.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_alloc_ns_head() points head->effects at an effects log owned by the
controller that created the head: an entry in that controller's ctrl->cels
xarray, or ctrl->effects for the NVM command set, which also lives there.
The head is shared by all controllers attached to the same namespace and
can outlive its creator. Once that controller is deleted, nvme_free_cels()
frees the log while the head still points at it.

Any later user then reads freed memory: nvme_query_zone_info() when another
controller scans or rescans a zoned namespace, as reported by syzbot, and
nvme_command_effects() for I/O passthrough on a surviving path.

  BUG: KASAN: slab-use-after-free in nvme_query_zone_info+0x4fd/0x6f0
  Read of size 4 at addr ffff88803745a5f4 by task kworker/u8:13/5985
   nvme_query_zone_info+0x4fd/0x6f0 drivers/nvme/host/zns.c:47
   nvme_update_ns_info_block+0x1b2e/0x2af0 drivers/nvme/host/core.c:2430
   nvme_update_ns_info+0xc6/0xd90 drivers/nvme/host/core.c:2553
   nvme_alloc_ns+0x1a9f/0x3e50 drivers/nvme/host/core.c:4293
   nvme_scan_ns+0x79d/0x910 drivers/nvme/host/core.c:4483
  Freed by task 5948:
   kfree+0x22b/0x6d0 mm/slub.c:6801
   nvme_free_cels drivers/nvme/host/core.c:5165 [inline]
   nvme_free_ctrl+0x1e4/0x6b0 drivers/nvme/host/core.c:5183
   device_release+0xd2/0x270 drivers/base/core.c:2640
   put_device+0x1f/0x30 drivers/base/core.c:3884
   nvme_sysfs_delete+0xc9/0xf0 drivers/nvme/host/sysfs.c:500

The Commands Supported and Effects log is a per-controller property, so
store the pointer in struct nvme_ns instead and look it up for every
namespace path in nvme_init_ns_head(). Each nvme_ns holds a reference on
its controller, so the log stays valid for as long as the path exists,
and commands are checked against the log of the controller that actually
executes them. The lookup stays under subsys->lock, which already
serialized nvme_get_effects_log() for head creation.

Reproduced with two nvme-loop controllers connected to one subsystem
backed by a zoned null_blk device: delete the first controller, then
rescan the second or connect a third.

Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
Cc: stable@vger.kernel.org
Reported-by: syzbot+76c0f0ce8f1e846b4f84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=76c0f0ce8f1e846b4f84
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Tested in QEMU (x86_64, KASAN) on v7.3-rc5:

 - Deterministic: two nvme-loop controllers on one subsystem backed by a
   zoned null_blk, delete nvme0, rescan nvme1, connect a third. Before:
   KASAN slab-use-after-free in nvme_query_zone_info() on both the rescan
   and the new-controller path. After: clean.
 - syzbot C reproducer, kasan_multi_shot: 175 reports before; 0 reports
   in two runs after (~900 controllers created/deleted per run).
 - Zone Append is still detected on every path (no "Forcing to
   read-only mode"), and direct I/O to the zoned namespace works.

Deepanshu, Cc'ing you since you posted a test patch on this report.
Pinning the scanning controller in scan_work doesn't cover this case:
the freed log belongs to a different controller, the one that created
the shared head.

 drivers/nvme/host/core.c | 21 +++++++++++++--------
 drivers/nvme/host/nvme.h |  2 +-
 drivers/nvme/host/zns.c  |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index beea23d04a70..e0fea859dfaa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1234,7 +1234,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 	u32 effects = 0;
 
 	if (ns) {
-		effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
+		effects = le32_to_cpu(ns->effects->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
 				"IO command:%02x has unusual effects:%08x\n",
@@ -4033,13 +4033,6 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ns *ns,
 	kref_init(&head->ref);
 	ns->head = head;
 
-	if (head->ids.csi) {
-		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
-		if (ret)
-			goto out_cleanup_srcu;
-	} else
-		head->effects = ctrl->effects;
-
 	if (ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
 		ret = nvme_query_fdp_info(ns, info);
 		if (ret < 0)
@@ -4141,6 +4134,18 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 	}
 
 	mutex_lock(&ctrl->subsys->lock);
+	/*
+	 * The effects log belongs to this controller, not to the shared head,
+	 * which may outlive the controller that created it.
+	 */
+	if (info->ids.csi) {
+		ret = nvme_get_effects_log(ctrl, info->ids.csi, &ns->effects);
+		if (ret)
+			goto out_unlock;
+	} else {
+		ns->effects = ctrl->effects;
+	}
+
 	head = nvme_find_ns_head(ctrl, info->nsid);
 	if (!head) {
 		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2cff9fcbf740..7d6ced8ed78b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -554,7 +554,6 @@ struct nvme_ns_head {
 	bool			shared;
 	bool			rotational;
 	bool			passthru_err_log_enabled;
-	struct nvme_effects_log *effects;
 	u64			nuse;
 	unsigned		ns_id;
 	int			instance;
@@ -620,6 +619,7 @@ struct nvme_ns {
 	struct list_head siblings;
 	struct kref kref;
 	struct nvme_ns_head *head;
+	struct nvme_effects_log *effects;
 
 	unsigned long flags;
 #define NVME_NS_REMOVING		0
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index e31ec6f4f94f..ef75448036f7 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -38,7 +38,7 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 int nvme_query_zone_info(struct nvme_ns *ns, unsigned lbaf,
 		struct nvme_zone_info *zi)
 {
-	struct nvme_effects_log *log = ns->head->effects;
+	struct nvme_effects_log *log = ns->effects;
 	struct nvme_command c = { };
 	struct nvme_id_ns_zns *id;
 	int status;
-- 
2.43.0

