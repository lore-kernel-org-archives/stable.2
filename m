Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795847947;
	b=XEZqseHJ89RTczZpHSt3rAKvmPgKo+gmWQ1l1CszJTqZRTIJ9o2jb6P+lRRrBBFw4MvS
	 xokiDev79/NLygIU9nplWEB/zq35ca7Bxn0S8rMQnnfhzRC527G9/1Rh7WGAjFZGJCP4V
	 +FGn/YdCJHPIXe/0kd1eRDipddzmZwl9n1izhYVWBHJ1VzlyuUVuJMUD9CReb08ZSfrq2
	 60UyVrmXegiJongEZEbWeyHVgyeaGOpZVcplL0uRO1AfYRP7xF5xYMOG43jywI0wLm2y6
	 aRWtddoKsQJwZwj+4FC9VylLp0Lk82u8CrQS8nF71cSECNDrBiXp4Off+09YNRj2PYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795847947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xJUrKT1/8wtWEpCHd0NA5Y6u4vvqC4B4ufA7sT35KDU=;
	b=KEdIdyFH5P7HvLIwC0166AzS/MFfMbZubcJqtVtLUnxfZrs0ptKpTCJWo87EkAx5+tSl
	 rrNwEWL87Bcc6h7aUnCy500fSCpA+pc6Al7QFd2ZTRDb718SN32Z5/0POMtGzTWi7Imdn
	 GJfxdVO9rBtOK3muCllkhhA1AlYQne18BMUaRPQi+8k/envUe1IQLbPA0kMwX+i3pzXGX
	 LDxTolqgBa9HfYqqpti3y8JoplNIa2PMSAvxYtTKDB7wzfP+1bHkTE2D4E/gkJPL/7ymX
	 1P3XHIlta39ZlYiHRG9Y52J9+bapvfWUOLtobTsqsM9nE3l8GO8TJBMielaaocRhuUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=furiosa.ai;
	spf=none smtp.mailfrom=furiosa.ai;
	dkim=pass header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=ba1ahpFs;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17E3606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 06:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B17E3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=ba1ahpFs
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8c700d6cc0bso4756887b3a.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 22:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1795847946; x=1796452746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJUrKT1/8wtWEpCHd0NA5Y6u4vvqC4B4ufA7sT35KDU=;
        b=ba1ahpFsvnPvTWjwlgWebqQ4SWgoLMcNVxRiKonVgBgPSD8T6vzBQp3nq07y2iytb1
         tC9Q1CyjZilMGLM4HNmg2VqaDyshbLMwkdHS1qtLVJH3DYPfQRUzi9kv+Eiu3zWG08R0
         E471q5oXVMIXQkuw06RoDf7eu4VCUVn1e9blA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795847946; x=1796452746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xJUrKT1/8wtWEpCHd0NA5Y6u4vvqC4B4ufA7sT35KDU=;
        b=IRjv0DS/GPV28ZDkNKk3RWOab16nvvk0iaqXW8fRo6PPicZmAQJveVSgMlqNISh93e
         O/oj2aDO8e8Cf676anb615PxvLnQlkrgkdqkWnL5ajRabxgo1iDMH0W0VeajEikyi8JR
         9U0DwoLhGYKygvds4Wdn8dVkGvYRIEPhr6p/gAeXFJY+oTL1WeO34pfuBMuUlsX2a3hD
         JtoBu1OjILNGEXlwIz/NFqpuPCG6nn4BmhsH4C3/zIB1mlkOQfj0wgwjf9XzkC0W6rsd
         mSS7SBxbdtDipklMNoNw9FDyRNI173KILxInksT1oqPJj1DLYKaApvCgIiunroLfHXoV
         NhAw==
X-Forwarded-Encrypted: i=1; AL+hErEBYtViGcH6H8OYhq9FPHWZJ2uzgcZW3h5P5GgKb5z4QOcjYV9YzJOhTmUSGRH7nqyzyIvl6IQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3FPCNqV9Kh19aJnZJbtZDBvGx8DXlyfRab7dBiP7a7RzZvfCC
	sxgO9Zv+QqatUiUuQsrf4zCt5LZiuORBAR8mikUwNZYeQsF/foxCXtkRT1llVP9vcjQ=
X-Gm-Gg: AZFdTZd5tzcH2nULmeO9K3eKggbiDuKy57fzxBIqEBwb3rRJJnbTj25c61+txg5sV3J
	Xiy4RIwok8EDEremoFWNeL/SrvdK780mtx7nLIkWcUb1JZLOCNu5msMVnzhabRoU/dramSdOiY0
	qVMI+7nxCdve8Rw7q0A8Bt2B34Exxn7WScIc4q09OYZWOmfhorjO+3NUgU2T3lVuVK04z1wf/rI
	omQaNoCwLNIk3+MQYq1Bg4OhUaeZGZR7M/KI81yUzlgp9XL1Ie2XzlgUFKuj6WX+OCaq381JXkX
	kLFVBVJuPmCbF5WEvZAXegFhzQJMtoW/Wn77Cg53eiH+6rV9fD169XbcjY7VyoZbPaSE0xO4gDs
	UetKrGHQ8hy+FPGQxf+rGWwebiPukF+lxvZ0cqDuAB2oClgG0GfMIL7WDw6HJLm8idyb2FvLLkr
	Q2V/8O8szjXwKgkLbzZda20QfSZvQLkjNJhmrxiYYrqNSsdP5mTKjUiPpySg0U8PXEdeIKKNtgg
	0SNGGQ0D10N6XdImBwaBteyOt8OEmZb4xdW0ZALopOtVcInke4NTUz+TQsZTQ6OJpKhAdcuiCME
	C6li6p20VfwB2Lj1W4uoh+5j6XWeHf2JDOxIfmBwSZZO/9dGguIGTRtfh/OuMVTQzv00fg4YYgJ
	0E6e54QETVpKV
X-Received: by 2002:a05:6a20:a106:b0:3fa:53f1:abf2 with SMTP id adf61e73a8af0-4014de5db77mr21193451637.29.1795847946035;
        Fri, 27 Nov 2026 22:39:06 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077944bsm13939838b3a.2.2026.11.27.22.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 22:39:05 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Haoming Gao <Naixumogu@whut.edu.cn>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] accel/rocket: Reject zero-sized BO creation
Date: Sat, 28 Nov 2026 15:38:41 +0900
Message-ID: <20261128063844.1537615-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128063844.1537615-1-sidong.yang@furiosa.ai>
References: <20261128063844.1537615-1-sidong.yang@furiosa.ai>
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

rocket_ioctl_create_bo() does not reject a zero size (or a size that
wraps to zero on PAGE_ALIGN()).

When args->size is 0, drm_gem_shmem_create() succeeds with obj->size == 0.
drm_gem_shmem_get_pages_sgt() then calls drm_gem_get_pages(), which
returns ZERO_SIZE_PTR from kvmalloc_objs(..., 0), and passes it with
n_pages = 0 to sg_alloc_append_table_from_pages(). That function
unconditionally sets chunks = 1 and dereferences pages[0], crashing the
kernel with a page fault on ZERO_SIZE_PTR.

Reject zero page-aligned BO sizes with -EINVAL before creating the GEM
object.

Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
Cc: stable@vger.kernel.org
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 drivers/accel/rocket/rocket_gem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index 8f802df3e0f1..9f3d85e3dd30 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -66,9 +66,13 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	struct drm_gem_object *gem_obj;
 	struct rocket_vm *vm;
 	struct sg_table *sgt;
+	size_t size = PAGE_ALIGN((size_t)args->size);
 	int ret;
 
-	shmem_obj = drm_gem_shmem_create(dev, args->size);
+	if (!size)
+		return -EINVAL;
+
+	shmem_obj = drm_gem_shmem_create(dev, size);
 	if (IS_ERR(shmem_obj))
 		return PTR_ERR(shmem_obj);
 
-- 
2.53.0

