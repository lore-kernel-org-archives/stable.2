Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FCE441635
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394350; cv=none; b=WvosjozVSwwgGPebovKEaaFpxrVh9V6/fXz7ujRdOpkHZcLUToTP8RPpjWKBOZottcpyKG4BkKmjSDxmIxBXEr4HB94OfNodHztzisgMuqhiv4WaArSagYxuy1+PhmBpuEUm/chN0hlbOBGTRobR7USov8qhZBLHEZRmP81eUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394350; c=relaxed/simple;
	bh=EkPEKXF+/UaDvmD1DSJT1a9iDr68rR/Sq93UlMmDacU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7ztbES1Sx84ZF3R81x78szdw8rAgbP0OIh3sqJT9ZsGw2ZTa7bHbHf2IYtjRF9aNY7nmp2o7elln0bxVQoOpErwkzKgfLrQWuZaxPP5fybdT57SP5oA3Hp4+yktBhDC5cHN9yoXTUjjWrjxhu9znC4yBfD2OY2ofRcdUmt6EPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oUzCrlYJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUzCrlYJ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1849521b3a.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786394347; x=1786999147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eYLBNqXF1zNAZBvL6Z7VZZKJwlYWKUq5oR45TMWjugk=;
        b=oUzCrlYJtOHTQ885ks3y9kYZicKST2Ilsg27nTZBMCtDUYUHCb1ZK/87sMvNeWxWi9
         h9ikkM7rR5CbLpoD0ZrJ/SNSSFtnA5q8pokGYwIui4vYOrxuH3btBoD505RiAetFl96I
         aRcPYFKDqN5NtlitJROdRbWxiq7znbjsUc0yf8jwjvydtolZ/D5ZXtcuF6shIwKEAalG
         tgBLPjXjs1pgvXv9OKmm6Ikcf9PPpxRE4qMHGuP0q7D6n0DO2JovrrkFkqLBjrpiGvtu
         kXsqyYWP9ddgBtnBbPjrwFACveNfnhXXjMwrSv/RZZ/TrIaFB2wodPVP4/EDYA78Oz1L
         V4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394347; x=1786999147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eYLBNqXF1zNAZBvL6Z7VZZKJwlYWKUq5oR45TMWjugk=;
        b=FM7ksBaDkWjM8O8YDEkS8VPi9bfeaoreveHK/zfxmHRdaKWrdq1HxJpmL6oliD4A0o
         Kc9932CVCeHRqX+SjJ9Y/ozizsR9EsOWt3XhcLIBcIu4Lo7xB9tGQLAqhYUPRbm+vMZt
         7mPXu/l74pjeDyLCTifNxYyVRn6ggjKEmvQe4XyZJvvP2JyiDsq6HsVWX/8O+DLblsdn
         T8DRJMKZEa/9MzohPTH6jiXrLETd4RZJloTdwksUPXWoWgIcIcKpMdS5jXS1015huvm7
         //skKQlS8MGTFW4Qf07tRY91UmxwFHvlWF8p3x/rtJUm0E5M+nqQFeD+DhGevTuSbRWd
         SH8A==
X-Forwarded-Encrypted: i=1; AHgh+Rp+FwiejpXqDd/Z2WILfyxfYRfXqX3upoBltj62o1YW72R08M6JBIAkh/JjR1SNSU4wjz6sk3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQ4K+Em2EztWwg4ryyut69ulgodavs+6Mwz5A/eyzaijyXseV
	i2x1ZwzSYL1Mumsehhy+WbPwgD3RXyq2DGZpstHnlCEmkCl51MCHPMmm
X-Gm-Gg: AR+sD13YnvetzDnj624E/ODO45R3aQct7hyWT6qA3dYNpoLdZgK3L1Jo9NXPmlJnA+v
	uZwm15dE5b/1aduXLwjBpSUAXZ6qdRaSqF0P8WPka0l4vtbg2eofeGF3rpI+Jf0gIHIY15qvxv9
	69kO6u+utXzW4FjadNq00/m6g76QWoTytF3Ud1A6GSN8LGnb5sbVSz8iC+iE+nmg8cGesb8Fjiq
	RIZGF+0b1V3h0MooD1NXzA+ftOKdgGXHYbEUCs4hKQNOZeapu0jUcH5CqIty82kOaQnpln94usI
	HS8FuoXvH/pSPJT7AzehQTjLPD0RcQtU8QVaPE5feDz6VKzex6PpX5zX3bMMo7f9+CGrgStcXV9
	P5R/sZFkRunzDsqEEwhddy+SV+HqsWRtxVUf2o1sIDv2HPV3LMrLus5QTU+XEnxzAMqVghyFmFV
	bxB1y5DW8Yo6HSlBeMjQcCQprBPgkZDgB4urSBymxkrTXnAEpcF8Oer+64UHk=
X-Received: by 2002:a05:6a00:399f:b0:848:42a7:1854 with SMTP id d2e1a72fcca58-84f4fee21bemr33610373b3a.39.1786394347422;
        Mon, 10 Aug 2026 13:39:07 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm4324001b3a.43.2026.08.10.13.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:39:07 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 04:38:21 +0800
Subject: [PATCH 3/3] drm/nouveau/uvmm: clear the dirty flag when unwinding
 an OP_UNMAP_SPARSE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v1-3-40df1c046b49@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com>
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786394315; l=1588;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=EkPEKXF+/UaDvmD1DSJT1a9iDr68rR/Sq93UlMmDacU=;
 b=xvwCAsSALBfo+gvo3ZaHDs3yC6zp/pyKzQwwXyN0p3W5AseCOv1a26TdDXBFUuDwtF8D64GKY
 ptfwp0aTPmpDgfsO50bna4ltQAqDVyxcUVxtlWFJ9TQe4/CGG/JkW1W
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

A successful OP_UNMAP_SPARSE marks its region dirty with
nouveau_uvma_region_dirty() and defers the teardown to
nouveau_uvmm_bind_job_cleanup(); it does not remove the region from
uvmm->region_mt.

If a later op in the job fails, the unwind path never clears reg->dirty
(set in one place, cleared nowhere) and sets op->reg = NULL, so cleanup
skips the teardown. The region is left in the tree with dirty set and its
completion never signalled. Later binds over that range then fail
permanently -- -ENOENT or -EINVAL from the dirty checks, or an unkillable
wait_for_completion() in bind_validate_region() -- for the lifetime of
the uvmm.

Clear reg->dirty when the unwind reverts the sparse unmap, restoring the
region to the state it was found in.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 3412200b21fd..76ab377f0e2c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1475,6 +1475,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 						    op->va.range);
 			break;
 		case OP_UNMAP_SPARSE:
+			op->reg->dirty = false;
 			__nouveau_uvma_region_insert(uvmm, op->reg);
 			nouveau_uvmm_sm_unmap_prepare_unwind(uvmm, &op->new,
 							     op->ops);

-- 
2.34.1

