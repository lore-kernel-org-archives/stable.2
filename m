Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4639A054
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265463; cv=pass; b=ne+ZppD6wFh/md8SuNTv4aqcGn7WLIuwqPMgnFG2+oFsSaVKi65AqEy9P2vaQ6OQC/DWbDLGdNNLZuzGxueAARWvk2Yo02vY7S6owLg/ww2Fsn6tfU0k9y5dVCRQyaxNpzcoQxxl64VxoSb7up/hFmSB9PBqbWXojyT6YH6sELU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265463; c=relaxed/simple;
	bh=JN/t2FkFifvzscJ/Ssx2FsFd82QoZZqcQMljAzuGXQE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kqiwFmNMUEV/GjjHVIFXxt3uEi8hGgYM06vmWrs7ViJT0cY0GQmppVj1rKZqxpTmHD2ozhwiKm6I+Mrgauduz9pp3RUuoeZdVQCB088ySq0Im4qyFt0/BJRYEFqutUIvdxwtDOrr43gnEs1BBzw75hxN+hOkJ5omddhiKyJKEuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BO/EhEHK; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BO/EhEHK"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01c79467so321341cf.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 05:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788265461; cv=none;
        d=google.com; s=arc-20260327;
        b=jidLEBULUmz86kwTlvsxAbq6VpQRm1lJKVuuP9krWLotfRQzUQK7gSGCOjRIqE0zMq
         Y4pMjLPZst0PtIEKyfRBje+fyDRaKiokRLwNfdrwZrWOWuoAveEeXfCP9f2wqon5LY19
         YgCFDF7sN+arpNDKaZ75y2lOKxVWPw0PFw0JQn0w5tpbUOj7nGmYmQQIr9cUzD+TjLRJ
         xlZFaxXKN7x5ZgbMmbk7hQQ6MuaJXrdvLzZG+OtyBTka8CRbfm2xnN8D9M9jDja5+mba
         7jQPz0H8ynU88Kii39RVTVYiCUqRm7sx7a3GooEXIa/uu5nI/Ea4sLgOrGVb28G4Q0v4
         Be2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=d8In7MroUMENUyC3EqegCPVqWB6peac9BWZUcxLxuQE=;
        fh=NB9gft7hlwAKCZZzJWqREZ5npL9k65MQgBEqVF0XcG0=;
        b=PdnfPbwqriqFGDImXSk+aBJAzwqev3L4Tz/K5oALSdV6llaYInHOS/Zc7LCLPqtJTo
         FehjbODTWdx57yPxbjlVDTRHXNWr0+MeVU93JOG2pHQapFzeEc71d/6oD28j3m65c333
         JDzR+vsQiS+24IBPKeLjSkZ3VTi6IDJV4X/4IIMsrTmjHcftbDD8zgSmEbuGgPtpXsNG
         Ad9dJAXT50uYOWeJ/TY+FQnqnT8X3WxkAa/U3A2txVED96pihFwGBGoxIEnfmgqZRp0h
         E9mxfo+MnW8XnFnBQ1eBz8GCeVb/kXZyi0lLkeXKeEKzDph/KNUUclDnNbV4oJgQBBFU
         Ks9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788265461; x=1788870261; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d8In7MroUMENUyC3EqegCPVqWB6peac9BWZUcxLxuQE=;
        b=BO/EhEHK9w798o1ujreR9Ar3bnmC7fAWkUMoU+hwIMVuo21Uhs9mWb7vNbsZ55JyiP
         MOXPIM1701TynjO3iJpHdDX3vhwosWMiHlFTvjtYxBl8INRfKv3OvyWLPkEem3174lYY
         09bFh8EI5AKNHKr8ExICdb8UjLvHzHxW6PivIb1qeAhT4EhSxhJaEV+FjMqvMONMRHX3
         LBZOrSDbsfC1V8Sil1dqMIPRvykNesda3OGLSmq1ilhjN0vdROOIv1OsEjoFjSSFZJhX
         9hyD1tHIuJOhUqWk6GOEo6s2m2G1tV7pZ9Rk+mp5k+yhCIpZUcyjiHs/X9d0jImnBXLX
         WXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265461; x=1788870261;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d8In7MroUMENUyC3EqegCPVqWB6peac9BWZUcxLxuQE=;
        b=Hr3PMPV4Ld0yxsW3KLQp9f46LDgmtKqJAFcr5gW4OhmkspXaa+xo49sW08GL1t2cwk
         dDhYfw7h5K17XYW07NDMv1zOr0cakkealZc6Hj1nSPY4MayN3qmMEs72nGEFZ4bu6/rl
         WYVFtIEqJTm5R+zFYRIikjp6857eimmtiFYM7OBYL6EeYLPdeKk4mJQdg7gQ+B1aZNRW
         EXZ+c4eGm9T1cGmjt5vMhj5YJkQpsDqdGJABXi4d4FXclJznRHeWWtLO1LPKjjnOIY2U
         22AE+26ctXy37WLulcDBuIDqL5ZsBvGedwc+89NFMAxbolntizuJzYuvumX68j1dQ8Jh
         owzg==
X-Forwarded-Encrypted: i=1; AHgh+RrZM/g2gAfW1U4sV9703Z17L346N6fYNBNFSAE+vQwvJpbWJ9XANywJXU0Ci7GNVeX0qMSoH5M=@vger.kernel.org
X-Gm-Message-State: AFuF++mxjjae2C/YL5vDEzsD8F5f+o5SSstEZooOX50RT4/dKhYfC108
	Ry37GTjpjYUwH8e0bdiljQsTPyfL5bf+V1l0C1uOaBbEgStAVRQGBq35k13mxzxihwJEqryc/B4
	GuG3lIENTrFyUZ+XGEhjGaPAhsch+5auxXMkfBbMK
X-Gm-Gg: AR+sD12SPEX/4nFb8YjO9AcOIVJf9/7xxNHYmgeLloK3DeOyaCoB8wEnsI7caIvuNt2
	qqkFOSnp2iHVQ/rQtzXeeCDd/VkD54e2/8aqNq43uzKkC65EvxhJIJrRtj1do26XQAbiGlLaqB3
	VJKpMGh6X1OCQG94+KQqqVdLz7nHgpkpDnizCAKw9Mk+Xu2fSxf5Em5l3OwTpjspMif6tpOeMJ8
	qREZLh2vzblImgM3onahhqQY005FubktI87gsE9lcOeuaiMf7iq7lndCe99S5SpPPFY06dQREYB
	w0Kn6sv+2opw5SyyoprBEAyS2i5N0Hfuo+I3+vcbJyIh
X-Received: by 2002:a05:622a:1a8f:b0:517:6dc0:698d with SMTP id
 d75a77b69052e-53024b7b7d5mr15608241cf.0.1788265459654; Tue, 01 Sep 2026
 05:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stanley Jhu <stanleyjhu@google.com>
Date: Tue, 1 Sep 2026 20:23:43 +0800
X-Gm-Features: AcwNN1WE8g6tSRs53V9lxDRCC9ypyaxRDWe_obKQX3VLlFgTm5cLh0_k_iVI3WQ
Message-ID: <CAE14pdef2u=Eo7M9NGdABzsjy2o2SO=Z-U_BbRn9n45nJJR+wg@mail.gmail.com>
Subject: [PATCH] scsi: core: Set BLK_FEAT_SKIP_TAGSET_QUIESCE on pseudo SCSI devices
To: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <mkp@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, hare@suse.de, john.g.garry@oracle.com, hch@lst.de, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit d630fbf6fc8c ("scsi: core: Support allocating a pseudo SCSI
device") introduced pseudo SCSI devices to allocate and dispatch
internal SCSI commands (such as device management commands) via
scsi_get_internal_cmd(). Subsequently, commit 08b12cda6c44 ("scsi: ufs:
core: Switch to scsi_get_internal_cmd()") switched UFS internal commands
to use this mechanism.

However, pseudo SCSI devices share the host tagset (&shost->tag_set)
with regular LUNs. During error recovery or host reset, drivers
typically quiesce the host tagset via
blk_mq_quiesce_tagset(&shost->tag_set) to freeze user block I/O.
Because pseudo_sdev->request_queue belongs to shost->tag_set,
blk_mq_quiesce_tagset() marks it QUEUE_FLAG_QUIESCED as well.

When error handling then attempts to issue internal commands to recover
or verify the device (e.g. ufshcd_verify_dev_init() issuing a NOP OUT
UPIU), blk_execute_rq() inserts the request into the request_queue of
pseudo_sdev. Because the queue is quiesced, blk_mq_run_hw_queue() skips
running the queue, and blk_execute_rq() blocks indefinitely waiting for
completion. Since blk_mq_unquiesce_tagset() is only invoked after error
recovery finishes, this results in an unrecoverable circular wait
deadlock.

Resolve this by setting BLK_FEAT_SKIP_TAGSET_QUIESCE in struct
queue_limits when allocating a pseudo SCSI device in scsi_alloc_sdev().
Passing this feature directly into blk_mq_alloc_queue() conforms to the
Block Layer's atomic queue limits initialization model and mirrors
NVMe's canonical pattern for its internal connect_q in
drivers/nvme/host/core.c. This ensures that blk_mq_quiesce_tagset()
ignores the pseudo device's request queue, allowing internal commands to
be dispatched while user I/O remains quiesced.

Fixes: d630fbf6fc8c ("scsi: core: Support allocating a pseudo SCSI device")
Fixes: 08b12cda6c44 ("scsi: ufs: core: Switch to scsi_get_internal_cmd()")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/scsi/scsi_scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 3b82e80e807a..eb48866ed0dc 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -336,6 +336,8 @@ static struct scsi_device *scsi_alloc_sdev(struct
scsi_target *starget,
        sdev->sg_reserved_size = INT_MAX;

        scsi_init_limits(shost, &lim);
+       if (scsi_device_is_pseudo_dev(sdev))
+               lim.features |= BLK_FEAT_SKIP_TAGSET_QUIESCE;
        q = blk_mq_alloc_queue(&sdev->host->tag_set, &lim, sdev);
        if (IS_ERR(q)) {
                /* release fn is set up in scsi_sysfs_device_initialise, so
--
2.43.0
