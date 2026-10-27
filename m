Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793070961;
	b=GNLFmbzLjo8DslfeMuJEAFHDxcWyZpK21Lt+/Rrpbh70pqRqHnNJkq6QpOD5YSChR82q
	 894A9xjZD4rdgicEdXU5lvY16rHv1U4zXrjz2aHM2Vx3NvzCFQzYxGS9640PMdSNsdDX1
	 l1ZUukrJ0EpiOFawD3f5SNBBkjXbWrgB0NdhAZAfOO9M+1CxIZc4jQcJDuMmEk5H+/u3V
	 vyGvloMXX3P6NsokSCDvnVw+zLRO55RpCOL1rgJprAWBGGhdaS0ATfpQTLwbNWF4Ij1AT
	 mNF9wHasC7TLVuiLpa+clarPS2oeLonjkaRTAAUqMJG+QVMHKdZUcv0EcRYeN/OLpGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793070961;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=vcMzYXM5+gaf2CTPQI0XuREV4OxjZWsWUv3S0ZwqH8I=;
	b=Fym3KfWSBR6eRvrIVmkH44d7S9L59IWZb4koyxu3729IrlvT72RQfWUo6ij0K7LKDlHU
	 bgQVrTMGdf338wlXjBEcH7q9ulQd3/QfH6WaV2AdnbHlBc7UNrUxQ/27F8eMP1MLKyGN7
	 63w3ZfBUpwmRuk+4AhVyuEVulpcGVSofr7UqXypY4NqpI0UW/0QVhigO2SLZWRikcq618
	 EIrFFugJ8Psl9rSbwebzVPTkOqok9lLZdcql6LYZ+a4pzhUxtbb+hNFul07B8GXkETkGG
	 Pvyupm79GwxB03lG/2yh/8CnsXwpnNgpUCeEcJ8HD6bW9NqjmwcXzwnGmfRYS3SggeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Pidx7iDA;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C8606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C7C8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Pidx7iDA
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so1209079a12.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793070960; x=1793675760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vcMzYXM5+gaf2CTPQI0XuREV4OxjZWsWUv3S0ZwqH8I=;
        b=0nf+8Qd9uMThT3z85GLAwtGMbmaTfIQjKypQG5vO2lVW9Bs+yjJwq9WeRq2cnxCv5L
         2++EZKdMuLiBgY/UVU3VWhOyCClZtDG0rp7Q4XeJMlEs4SBW91dZj33TGk+/qSH+JFzp
         8amzPnaUeyWubSrhGShUIrYE64omyUx3F3/7CXPzJfrd4zNjWSu5TARGBTJtUTlGuEG+
         5ATgahl8tdV32sxTgy9YSbUj8TGga6KyPd0lcWtQ/Eljuhv/eqDpt2QUfbcPUNZruBuA
         Gnwj3y3KJ9nENwRUnHKrhPw0U6zUWgtoMEXA06VK83+BYgwmWEl03wcrmKVfwsaF1Yuu
         ilMg==
X-Forwarded-Encrypted: i=1; AKwUvBxLpItu6nokfneuhLA9D++dUqxRLpsUE4wW8xfJ5i5oPDJzbxTAi3uU/FHwXnVBERTIkVoohJ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnQVLTpVBK3Odh5MwUyT2d7X4aaC2JphtLjBsSF76GAhOFgWGK
	mBxXXRXC9RQ/gNHV0TPXuswSPuM/iQNFIxXSYfLJUJvmHLGkLHay0o1OeNPEM1iWoUVVPerIH/c
	GLo0xAZ8qqxo9EqwMan1hSQ8WB63KynPrsemxkZATznFgqax5u57gnKRZROMwcQYr4YT9mFZojv
	Di9geaRskdcGIOpMAutRCDAwMjKsQLAKqfuXqXZMS2xO6/VbksR904L/1NQ9/irD3NyJrt/+IBK
	qkcEErN
X-Gm-Gg: AYBFou2vImeTKGJjiaS3LdBr+WxpZeAUG1qHJRy41R49KyL69AUp5UtvTJjhEfeJjDY
	llkeBduCU4wmmuUyqjyE4wkffHLlzFjErbG67jxe68bh1MU/QmNyy9kluSya91gsSaIuzdAIaVy
	bmqfKcPOicx0aaQwRlLiM6HatsvfwhlBaB5TYc0++Qbt7FfM/p4g/tpOU5gnRql1NTB3RfZxeA4
	Rra3+QgeawLbOJw2Ekialvav23tb6ryJraceBi7qzgQzi9BqaEPkx6v4Jk2TMUlkOrgxYs7JxtI
	Fal8hIWdLL+1HcQV5WGKlgR2B85PyzSlVMSEJHBFoN2ajmEV+Sgs6AdSdMmZmRMyzt3OBmUOawe
	YNvaeInUchX6ZJTu1szBLbPWEQzyoWBl+cPiDLYKl1dn5Z/LUTbxPmeR5UgW4/Grd3WQrRpv0XA
	+wuq7AnwxI8z8fRoQN6I0JQZcjqonjr0NB
X-Received: by 2002:a17:90b:568f:b0:3a7:e11c:4e6e with SMTP id 98e67ed59e1d1-3adeae83450mr7073583a91.59.1793070959761;
        Mon, 26 Oct 2026 20:15:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae406dc8fbsm1105368a91.1.2026.10.26.20.15.59
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 20:15:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91b8306ba68so94975646d6.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793070958; x=1793675758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vcMzYXM5+gaf2CTPQI0XuREV4OxjZWsWUv3S0ZwqH8I=;
        b=Pidx7iDA5crppEtrIodklSeTGYkvj/lMWQzyLInaU6iTXqiG9moZ9fo13wwe9TaxiV
         UMwp8M5t83puoPDc/Q6SyOWN2cPHLhN7s/w6xTYsAWTednYeCkxH5edXKAWi4HE/V9uU
         hwOItFKhSFcQ0BdBwQXI+/nQJCPDqTfFbX7CY=
X-Forwarded-Encrypted: i=1; AKwUvBy0Ic29qMs/aTlIEoM5HkBaVTA7UucICaNBTlMRI8TthibeXrSdCPFmxl2DBlm8SgmWo6dDrwo=@vger.kernel.org
X-Received: by 2002:a05:6214:4888:b0:91c:6c93:4482 with SMTP id 6a1803df08f44-91c6c934827mr36407616d6.23.1793070958400;
        Mon, 26 Oct 2026 20:15:58 -0700 (PDT)
X-Received: by 2002:a05:6214:4888:b0:91c:6c93:4482 with SMTP id 6a1803df08f44-91c6c934827mr36407406d6.23.1793070957857;
        Mon, 26 Oct 2026 20:15:57 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a69853sm90478946d6.6.2026.10.26.20.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:15:57 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
Subject: [PATCH v2] drm/vmwgfx: validate backup buffer size in command buffer processing
Date: Mon, 26 Oct 2026 23:15:33 -0400
Message-ID: <20261027031533.2241918-1-zack.rusin@broadcom.com>
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
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

vmw_cmd_res_switch_backup lets userspace bind an arbitrary MOB to a
resource without checking that the MOB is large enough for the resource's
guest_memory_size. The dirty-tracking bitmap is allocated based on the
MOB size, but later accessed using the (larger) surface size, causing an
out-of-bounds write in the bitmap that corrupts adjacent slab memory.

Add a check that backup_offset + res->guest_memory_size does not exceed
the buffer size before allowing the backup switch.

DX shaders and stream outputs never set guest_memory_size, and both were
allocated with kmalloc(), so the check would read uninitialized memory for
SVGA_3D_CMD_DX_BIND_SHADER and SVGA_3D_CMD_DX_BIND_STREAMOUTPUT and could
reject valid binds. Allocate both with kzalloc() so their
guest_memory_size is 0 and the check only bounds the offset.

Fixes: a97e21923b42 ("drm/vmwgfx: Hook up guest-backed surfaces")
Cc: stable@vger.kernel.org
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-34068
Closes: https://lore.kernel.org/all/BYAPR01MB38301CFC012E873340F77E3D80662@BYAPR01MB3830.prod.exchangelabs.com/
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c      | 8 ++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c       | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index a9136a6523cb..0156aee84c9f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1718,6 +1718,7 @@ static int vmw_cmd_res_switch_backup(struct vmw_private *dev_priv,
 {
 	struct vmw_bo *vbo;
 	void *info;
+	u64 end;
 	int ret;
 
 	info = vmw_execbuf_info_from_res(sw_context, res);
@@ -1728,6 +1729,13 @@ static int vmw_cmd_res_switch_backup(struct vmw_private *dev_priv,
 	if (ret)
 		return ret;
 
+	if (check_add_overflow((u64)backup_offset,
+			       (u64)res->guest_memory_size, &end) ||
+	    end > vbo->tbo.base.size) {
+		VMW_DEBUG_USER("Backup buffer too small for resource.\n");
+		return -EINVAL;
+	}
+
 	vmw_validation_res_switch_backup(sw_context->ctx, info, vbo,
 					 backup_offset);
 	return 0;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index 39811cf19db1..033157efb1fc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -597,7 +597,7 @@ int vmw_dx_shader_add(struct vmw_cmdbuf_res_manager *man,
 	if (!vmw_shader_id_ok(user_key, shader_type))
 		return -EINVAL;
 
-	shader = kmalloc_obj(*shader);
+	shader = kzalloc_obj(*shader);
 	if (!shader) {
 		return -ENOMEM;
 	}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c b/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
index 52c6cfa163da..34d5b71fa42f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
@@ -284,7 +284,7 @@ int vmw_dx_streamoutput_add(struct vmw_cmdbuf_res_manager *man,
 	struct vmw_private *dev_priv = ctx->dev_priv;
 	int ret;
 
-	so = kmalloc_obj(*so);
+	so = kzalloc_obj(*so);
 	if (!so) {
 		return -ENOMEM;
 	}

base-commit: 8ef66514d7b993c9fb96a5886f001e3556610c1c
-- 
2.53.0

