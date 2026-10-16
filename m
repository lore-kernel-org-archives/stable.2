Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F93BB9FC
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158938; cv=none; b=TLP2NMBoL7yZaGECj7dSwkHrL/pgW70VGzGDBWO8/+qfLJqLauXQ20Gi3wG2Nf0y/4Te8gAO8iyFO6qP8uSEpLMTd7WB7wvteIKpxZeJrOwPE0E83SL2uHA08jI/QjLP1GAwahqcYXIPdoxIizC1std7dQs+f/ZB+bjqml38Kp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158938; c=relaxed/simple;
	bh=WgH0xFGsLcxChp9qekgARXHm3ntKjhWawPAWTCPfAS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccjzl3FBBxmdheVW48WXHqixETuqBgv8RAsjIh466XY5rGKAMoSwKNJjMxsyU5eA0pAEQPvnF2xlNmmKAM1atSnC6rjZp4a3t1agL/rSH/ZVUw0GwxXcNMDzjhm19g/AdnxPDh7JYFpRQve82EgJWhQCdNXT4yg0EQYzzfXXUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP6XiVFy; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP6XiVFy"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1609513a12.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792158935; x=1792763735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaG+BrVADgXDwHo831rR0nkrlIE/ZtOkilAp8e2t4CM=;
        b=IP6XiVFy4O4dxgRkddrCfQ8p30NCiUIMrHRL8LLuNKVQzXfRK7QW3z5jjKhMnbM91x
         7xf946aV8eF3+zEDQ9qvvZZMssd3QFkKMgb6riPRHzLrMGI20aPIgH3y4YOZxftfvJl2
         wdaFI+0B2JBI+96USezfU4BOxZIcjvWBztqpii7GTVnk7RIQVeJhHzxxaUaeaHEXYUkZ
         nFjlM1UmwCzEaIrPi1yNJ2IjPU48i5Mnu1vTZvgSQUiHrhfVARbp+p6iUFuJDor9EvTt
         3spGOamte90OcScjnPT7WriLe4hiJkONzRRXs0jaPKqX221fp6J9bTg20j8ZWKDgr36j
         LBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158935; x=1792763735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FaG+BrVADgXDwHo831rR0nkrlIE/ZtOkilAp8e2t4CM=;
        b=wyyCkAt5TUbAujx3z/UJSCbmo0imQj2Y01jqrlrg3pXNDmoj+6LQFFVSlRDwMZrixc
         BFbbnqRm9uLYFZ3vZSe4zHROAjVvSAUHU2C+i/gw8cjyEZt2YFqLQ12/B35QmvHgKD7d
         mUmz3wZlOlAgTHJZsnGl5siNX0bz//JL1C1SKCLbGhDDweEn/9hyzPobzMgkGpFSyklF
         XxIrhHFwIao7z3NysSALenOjcl1jv41JJd5KqjmiCCBvF56d18QSLZjEfkO9gUUYaXUS
         5sHz6t3ht8p4NO7Md5omZyjra0saXguJsR+KGpkhIimcgchQ3pKPIIOACWlLxDyATJQ2
         TQgw==
X-Forwarded-Encrypted: i=1; AKwUvBy/SF98/mUkH5n1Sf215FdUMm714i0JD1tgGROEJ6tPN4I5KvQlRnTYaVrnb8tRU2683t+Na/A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBkNFnVcFfB5e+BeOZQfuxwtQ0BIwTLfqa3O35f10jM5o6iu3q
	/mbdxkkSpnyu2F0V3rVr0nQqxJOtGWgwzl0AnGqQku7LwNPXurZN1VC0BFX64rdb4cA=
X-Gm-Gg: AYBFou2enrNgndlAdJ6BaY6/zOM1W1dDnN8TJ2s6R+0npES8YyYVsffowmNuW6ML3V0
	DPZyXWVuU9Y3OCQ+/Ab8jQsU1FPqi0Hq90mhJocLWehJ0iTx/NdfK7v4ORzHLK7Clqvx86NrCom
	47q+lVjVBT4nJH+RAoeuhkzBrUsbUIhPS/Z5RU6kX/8tToWoR/wsqcCqCm0fkSJZbZZSq9CmZl0
	9OaU6YvtO81Oo//j1m07ZPfJvAO7hDZzh1Fv6dbdS3QCaFI3DXnWbIiQpyCJW622GagG7UsRNrL
	TMjcBjGCRfovbn0IUQi36XKyXwiNo+u8hTT4poudaM56BHLd2m7UXr7JQ3FuDDKB6+SWkQdt0vp
	PqIdiRi3eKEikXC/UhdstTtOrKtEF5z9DeQZCEiSQT5VPdFoblkjd/zXFEqCK2IccPlkaCuhjHx
	RjRj23N9PdUdPb0kKSwZjd50YNtUyd9D9h0+owt6jVvraDqVnjvnDL3g9I4s3Pm9xA
X-Received: by 2002:a17:907:a317:b0:c3f:2:6faa with SMTP id a640c23a62f3a-c401e136d98mr341429566b.1.1792158934663;
        Fri, 16 Oct 2026 06:55:34 -0700 (PDT)
Received: from beelink ([187.15.113.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e328775sm75262366b.7.2026.10.16.06.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:55:34 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v5 0/2] HID: multitouch: fix use-after-free of haptic data on delayed input release
Date: Fri, 16 Oct 2026 10:55:14 -0300
Message-ID: <20261016135516.2957381-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009103333.2476105-1-qwe.aldo@gmail.com>
References: <20261009103333.2476105-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Benjamin,

Thanks for the feedback on v4.  Reworked as you asked -- devm_kzalloc
stays, a devm_add_action() handles teardown, and the try_module_get
reorder is now a separate patch.

Patch 1 moves try_module_get()/get_device() before input_ff_create()
so the old input_free error path (which returned ret == 0) goes away.

Patch 2 adds a devm_add_action() callback in hid_haptic_init() that
does all the resource teardown at unbind.  hid_haptic_destroy() just
sets ff->private = NULL so the subsequent kfree in input_ff_destroy
is harmless.  input_get_device() pins the input device for the
duration of the devres action.

Changes since v4:
  - keep devm_kzalloc, use devm_add_action (Benjamin)
  - split reorder into its own patch (Benjamin)
  - single-owner teardown -- destroy only NULLs ff->private,
    devm action owns workqueue drain + buffer frees + ref puts
  - input_get_device pins input_dev against concurrent release
  - workqueue drained before any pointer NULLs or frees
  - input_ff_destroy on devm_add_action failure
  - no hid-multitouch.c or hid-haptic.h changes

v4: https://lore.kernel.org/linux-input/20261009103333.2476105-1-qwe.aldo@gmail.com/
v3: https://lore.kernel.org/linux-input/20261009110509.2432308-1-qwe.aldo@gmail.com/
v1: https://lore.kernel.org/linux-input/20261009031207.3233206-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: reorder try_module_get/get_device before input_ff_create
  HID: multitouch: fix use-after-free of haptic data on delayed input
    release

 drivers/hid/hid-haptic.c | 87 ++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 25 deletions(-)

--
2.53.0
