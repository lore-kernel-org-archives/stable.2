Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792464660;
	b=a8K9nleiuW1eWdUWQu8L9lDYl8m6qdFR9Pxi62Uu8rEik3X6d6vL5XAIoFzorEVUv3c4
	 uev9602AbwU5U1vTuzWCXYD+qRg98FE8eKtJFazK2NSgZasnXkgK5zjQnstJQg1ElN5Pg
	 skCO0e0GLu4xZQIepgzemhn7gLeFr0fEOZNv44+sUPPLrcv9xs7x6+xHuJ4JTeygNfk/M
	 5dmaJv2INZYt9me2sMHjHfnWMWQ4jczpVfaxbL6d4c0il/P5pNGgFayirnNF1DlQEGj51
	 MS37YlD/RaMNosINdGEiHmTgCj1xYurkKBeWGwUmkEY9TerHookQbMaj5u6k5MOrLuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YrHXlTj62K9347P7OmkxD9vCvcqzaK1MyEYVZ/+sypU=;
	b=gYEScOk41vR586H4iX3zokqq67odTQO3cUltV1FGI6FcvvGps/rit5UShSb/C2w29BtL
	 WjG2H/i6BmfuW6BWtc4ivozDn75UPE5N8JytHwHVzAlt2fMRpaBf2R97FnsuWZ/3z2op1
	 NnjBFCep+LgQ4zwxHn+f0d+cO0CLZaWifG4SCx3cCQeb3Yt34hI9jZWOLowQhfJozt/j9
	 2Kq1magx7P67ebsaCdTxjIGEoBDBUaAlaJNz5UWgZj1t6oqCasDepCw+B2UcMuFWFgdEp
	 Q5+scNY3PdHna8PCk0O+bmiwif5HYFujZhZmpaEB5lTdrF1TgTxAPBBMJAsgGIGKvtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DRml406R;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C465606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 02:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C465606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DRml406R
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso460109b3a.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792464659; x=1793069459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YrHXlTj62K9347P7OmkxD9vCvcqzaK1MyEYVZ/+sypU=;
        b=DRml406RG57NaOdh3ED/sNM7uMKO6h2ZVf4JyUI7Yk9/FGJXnsLtzqX2zgSBgjPwMx
         MV3k0gwCdFs566QTZVddeTG2eTcpk9xAYqMwr/sgLL0WKB/ZjBYrV3aOznguUjFaL54G
         d/cVRElUpyNt4HQQOka3Us+qQBakbxpqVWa1TqM0BepWGCv7DXKxOQsFS6MB6Lbcnr2v
         Q0z5vjX7HcL7+IrK7teMhWmMl4hTcyCjnrAdeTjC2cTO6f2UFGa/MywT8kZv9pZ0D+pc
         xfm4oOeHPxFb5dhfSpCWSxytZ4X+huZfO2E/X7kQeE4xO/RdgzbqjDiPpJvhUJ3YHpv3
         Tiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792464659; x=1793069459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YrHXlTj62K9347P7OmkxD9vCvcqzaK1MyEYVZ/+sypU=;
        b=rBa07yXOkZbkjzfU3Ez7EmN4IIeASDRpSq2Mj1wZbSV2ruzS+o6ZOjId+1kiQWw7BH
         dLup6czFSZOSRPNYeQNBmrI5BJOuTPAlVYn9QnVKlWcZgkn+eJ5hCo0+kEOJKZbPBGtR
         vltGw871Duhmgvt3QuJH8pfs/Kh+1zMEzKmqMRzO4JexsRmy4IKXECnt+ZQ/wKpZlBM1
         DU4+dc7rp4FWmWWTl8r9m5yvcJJ5dkMrX/5+0s3XXD0pbbHZTbqkKPqEz2Kog4ckqeuu
         DZZ5xkTa5c8vx2ULF+O9OHccmyvvX5ncRQRi3Ra07ikap4vxlrGe2+U/3ObKa3VhkHCG
         DsdA==
X-Forwarded-Encrypted: i=1; AKwUvBxYS9iY1g3KBU4nc/xsiQSDUT8b6EHApstfcIqMIjaRq0y3E0yg/L9rkWNlXWVcBcGXFzdwy44=@vger.kernel.org
X-Gm-Message-State: AFq9FYIut1cuVCbJUnuDzuDfnii/YCdl6F+j612VCG8GYRgLHNr1nja5
	K6B+csuvsqHD9Mk4n4tTE+K4E6xDutc/pjWWENMOXFEH+jfaszY/Q0sp
X-Gm-Gg: AYBFou0PsNM1jalFwHTRRTyQojeMA+IwVxyqgKxijOoCnmNB/9p6IT+l4owb7jd0A9b
	q/30v47UT+7DtTUUrK/uRxWd70T6lGuICTd+uuWASX952uoXH0epMVIlBKkuZ42Eedg6xViEmPb
	j+PU7rmEkGOkLIUZ2j2OeENeKCkA6lpan36foxPB9BgYDndOrDFkIJbLd+hBJ4TXcMgcL8wlqUr
	uOX/GM8Xk6wALiPz3xZ0qmcpyNBADvnWwn7sl6LnpTOo+SU3udO0t/U8QeogofqSVE+19Ftav0j
	dJ/Bt5Uk4AOEBgxUU6N0i/ZrViwpNICCyyV+3Y9aretqGDXfk5Yd8CTPz45IN0qvkgvdORzxltG
	jkX2l8P5EBsittQXtQX3r8Meiu0wLdbrRX42ej1/ErLl8ZybBqTjnBjjsqQmd7ztbNluy/bgWn1
	qEZJvtlEMsA+PFrqtKPzyqmmigQ8iEeB2Z8HixLsf4viBd9YyFFOsMN+iK7wb0Yy7p2Qf+4FgeE
	dFU9z85KnLVIyowVKfweA14FWSq5bTd7QvuwmmAkwVCrS3zeHWvRK2YUFDF3LvUfVkgW/WDD6x+
	NFrFg0OVYejoK7m82Xvyw7wtjjhvpmz7REurqpiHuTbxoPzG
X-Received: by 2002:a05:6a20:a121:b0:3de:76da:6b9 with SMTP id adf61e73a8af0-3e226057ab4mr8478461637.68.1792464659552;
        Mon, 19 Oct 2026 19:50:59 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f579464besm4613442b3a.34.2026.10.19.19.50.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 19:50:58 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvmet: take subsys->lock while force-reconnecting in nvmet_subsys_attr_qid_max_store()
Date: Tue, 20 Oct 2026 12:50:47 +1000
Message-ID: <20261020025047.88297-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014054727.53183-1-yuz08559@gmail.com>
References: <20261014054727.53183-1-yuz08559@gmail.com>
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

nvmet_subsys_attr_qid_max_store() sets subsys->max_qid and then walks
subsys->ctrls to force every controller to reconnect, but it holds only
nvmet_config_sem (for write).  subsys->ctrls is protected by subsys->lock:
nvmet_alloc_ctrl() adds an entry under subsys->lock, and nvmet_ctrl_free()
removes it under subsys->lock with list_del() + kfree() (not kfree_rcu).
The free path takes no nvmet_config_sem, so the two locks are independent.

A controller teardown (host disconnect, keep-alive timeout or fatal error
-> nvmet_sq_destroy() -> nvmet_ctrl_put() -> nvmet_ctrl_free()) can
therefore list_del() an entry while qid_max_store() is iterating the list,
corrupting the walk.

KASAN, concurrent "echo 128 > .../subsystems/<nqn>/attr_qid_max" racing
nvme-loop controllers connecting and disconnecting, panics in seconds:

  BUG: KASAN: null-ptr-deref in nvmet_subsys_attr_qid_max_store+0x10d/0x1b0
  Read of size 8 at addr 0000000000000090
  Call Trace:
   nvmet_subsys_attr_qid_max_store+0x10d/0x1b0
   configfs_write_iter+0x1a7/0x250
   vfs_write+0x5df/0x940
   ksys_write+0xfd/0x1e0

(also seen as a general-protection fault dereferencing a LIST_POISON
pointer at the same instruction.)

Take subsys->lock around the list_for_each_entry() loop, matching every
other subsys->ctrls accessor.  ->delete_ctrl() only queues asynchronous
controller teardown, so it does not re-enter subsys->lock under the loop.

Fixes: 3e980f5995e0 ("nvmet: expose max queues to configfs")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
Tested-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/nvme/target/configfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2b69ffc..23418fa 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1684,8 +1684,10 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 	subsys->max_qid = qid_max;
 
 	/* Force reconnect */
+	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		ctrl->ops->delete_ctrl(ctrl);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
 
 	return cnt;
-- 
2.43.0

