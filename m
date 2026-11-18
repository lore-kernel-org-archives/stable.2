Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022380;
	b=DyHSJsmu6onV5ae1+Svk2Dk4Nyc45bSpp3wJi2DcXLEZGz0UwVOEpx47VpdACBWe4KlF
	 1H7g+kEzlNHmOGciBVmKEqvacwW9k5IU/vhgqgkKjYY9a0+G9gNzlTCy9Qm0hnhKeqoJo
	 ev7vL3geZWKO5bdl01B/qqBRfIyMkKJIOu8Xl/g9VR5dQyzgeG9DPtXpzwL7BPy7bEsF/
	 0qC7tFZ9chRYXQsW2QeW/M63AFvcmlKbASMnl5XR/xS2F+duzg8hbDE0kV597E/qBRHmQ
	 ly6gURE+O0vLE70bmU+9aVfX1Lpy6Ux7cZ0bBJCExVuMieDEbCDyaaABL2Y7qyXrWjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=6gP6svfhzOhB+3p01vqjLTOkJSkqMxk4Z3G7OPboewU=;
	b=ceT/HGwTDxNZXRPkDde+m8n6D2D4Muy6cJkZBYWxZ/bxhMUgr1PDgrDtzU4S+w3j70ex
	 fwKOFSaQjl3cOZTfT4B35OMvnz+B/XU1yuWqftcMeGz3/uxKGx0xB/cghpBhV6CPiRmvl
	 Co2sjQUp20aY85X20aHJAyngQ5EGOkE+8DSWLF0Z/132+YnqImM6a0GouV18/dta+9pdK
	 IYPxCZuHhM9yxT17AYAiKF5/moKCoN1uZWUSi3EzbB1rTp+KPQ+GekgPT0ytu0bWW6lrY
	 NoHsc2lCle05fnrF2eYCkmcoT5xBUeYgWF70/Ui1quBovt5hyE3szdF+w1ptY2Q75PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySryMbre;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD9606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 17:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50BD9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySryMbre
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6d68de53053so933499eaf.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795022379; x=1795627179; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6gP6svfhzOhB+3p01vqjLTOkJSkqMxk4Z3G7OPboewU=;
        b=ySryMbrerU2OL5LMFOG00781tRrBu4NNWGf6VTub9ChTa3BRCTAIfRf25dhoc/5vkn
         Zp1s5aI4rfuyxXxA89jB9pmB7gE8VDz5zp0Ox2v/vwC9Qqq9Bshc+jssSsdnfOPUCkFY
         lN3kCayeLN5tu3X4g9+DFj1m3r/sATfyaRm6E8FWlgTRA7fwzFg4Nnu1a4yt5Y7QBkeQ
         EZlBADO3E+48yoWXnhjaFLfx7CBnrCuhBO2f0VC54T62hC24JdYIIRXQy5lOFCANjyL4
         5t0J4kJn0HpR30ic0AOGIcdKOfBxxB7vwsUrionTKEyrm6kOcVOFIKETsR663vRwRcOy
         3WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795022379; x=1795627179;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6gP6svfhzOhB+3p01vqjLTOkJSkqMxk4Z3G7OPboewU=;
        b=v/3hFeJmvclnU5JwnlpBx6xIvM1B6beNrCUWB/5uMxt+BD8q0/TyuFB2f2EBk/TnAk
         b86MldoWkfY6rRcJ2iAWtixZbH+UfgJBx4WJDZkW8l1YEszMQDZ5HcRyXxZyey1Vfmfx
         b18MyxSFf5AIYwAS8E92lHlZJSWYm/ytIfos6Ewvssflmbb/FQw6CHFaOX2Ancjf8Lqi
         F7X+0M7hm9/bj8usW7HsTI2/dnnQOvOkFtMmJRatIP/2kgKMxuSOP/mo7WQvhjpf0Q2w
         TlBb7HIqAFXPUR8OwAr1655sCL/h0M7OyHC0wCx3s5GfsheRbmRqCIglBOqLZ/Z6Mwzq
         IhpA==
X-Forwarded-Encrypted: i=1; AL+hErEykQPH3zVoPYbEwMKqhffKf6x8LyTjhw8U+aX8BmjsE0Qn24zMkM5XNM7COJKAIDF2nNQoQ3Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LnmJQC22biZP1I6erkrViZoGalk6RzIiPaGKLLJSBIzljliES
	GHPlAjkrOoJdDMZnL7Lk7xjDeKauksHi16l4ZWgqaoxtnD8ux9Fc52Cf
X-Gm-Gg: AYBFou2DlDAFy/r8uQi5kGR+NAaMM7ap/c0g4q6LwxpOl97w/WbP2mwTG31PCf3fRjV
	OYfhZDXYTCzS7rMr3RW/qy4XjQzFLt3FidI/RCI5NxaoGgmdkiDxQzEOfb3wA+mZPRdWr3m/w+w
	hLGz6r8ZgodlfRbvZVqKNNtk96UqL9L2ahPqzyiCI751RX3aCNwORNV0h98BaTbxa8QdqI44WV+
	2x1UD1kD9T0r+D0ktefVjp5Uk7Fo/s5eVoHKNRZDFt0bsVHh0s648QNQfu01RafCNLwtz+Q6HV7
	tDAkJ05z8Zvgh2LampyRBD1dtYKVxuSwo3hCNwu5yRG8qVdRf23kZmZfakBqJkgIjnEuGPerrCa
	mapOqOo6xUoSlbiLfW16RyKy6PAsQPomg720JoWITwkjSqiU/dnT2nHtN73zjunMj55bFof/VSJ
	o+7vty4B/FEMbX3o+Oy8Km8TDV7Wt4JtLe8PgYshjHn18HSJ9JtM86f5ZlGLehWF6/gwKFg8gIr
	g6SwkqbEQcOJsqmn6QktPn660EN4LbSI2YkA0/izD5O25VMvDUZt3mV1LQM523tgqc5E7rtaI/u
	F8MhBFZyFsSo2ZU8yJEiuPcjy9WadmwbOsw9MQ8IBJylePYS9TZDPf3DaUL4Hr4MCfx0zQaYpdD
	J14r/psKNuep5skyQP2kezzVcROW1jmhJ+k9h5ZA5EqDWiNZ3XXuphDfAw9NhsmnJiV61yuTN+n
	bFxTLAoIOrPIIWlhBlRfotuLubHzul4fX81IuDSF8zlLlFeT3xU2s=
X-Received: by 2002:a05:6820:c3c8:b0:6f5:217:b0a2 with SMTP id 006d021491bc7-71b1827bc1fmr1617469eaf.12.1795022379086;
        Wed, 18 Nov 2026 09:19:39 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f021298dsm2495575a34.16.2026.11.18.09.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 09:19:38 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 18 Nov 2026 10:18:36 -0700
Subject: [PATCH v2] mtd: core: skip empty read and write requests
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-submit-mtd-empty-io-v1-v2-1-b980927931ef@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0K6dgxTmmpceQ/DopQBxlhK2kokh
 Ltb8AAmf/OS//5fRaTAFMWtWEWgmSP7MYM8FcIOZuwJuM0sZCk1YqkgvhvHCVxqgdyUFmAPM4I
 2pW6bq1ZYocjyFKjjzzH8qH+czSfZtK/tjYFj8mE5nmfce39PchCqTje2UxdF0tx7Z/h1tt6Je
 tu2L/6wvzPOAAAA
X-Change-ID: 20261104-submit-mtd-empty-io-v1-6a06db864131
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

When mtd_read() and mtd_write() became wrappers around the OOB helpers,
they lost their zero-length checks. An empty read at the end of a raw
NAND device can then compute a die index one past the last die and hit
the WARN_ON() in nand_select_target().

Return success from the common helpers without calling the driver when
the request is valid but has neither data nor OOB bytes to transfer.

Fixes: 2431c4f5b46c ("mtd: Implement mtd_{read,write}() as wrappers around mtd_{read,write}_oob()")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-198544@kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Clarify that the invalid die index triggers a warning at EOF.
- Link to v1: https://patch.msgid.link/20261104-submit-mtd-empty-io-v1-v1-1-3f6bcf474e2a@gmail.com
---
 drivers/mtd/mtdcore.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index b170c3144ca8..ea21dc1bb5de 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1805,6 +1805,9 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
 	if (ops->stats)
 		memset(ops->stats, 0, sizeof(*ops->stats));
 
+	if (!ops->len && !ops->ooblen)
+		return 0;
+
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		ret_code = mtd_io_emulated_slc(mtd, from, true, ops);
 	else
@@ -1849,6 +1852,9 @@ int mtd_write_oob(struct mtd_info *mtd, loff_t to,
 	if (!master->_write_oob && (!master->_write || ops->oobbuf))
 		return -EOPNOTSUPP;
 
+	if (!ops->len && !ops->ooblen)
+		return 0;
+
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		return mtd_io_emulated_slc(mtd, to, false, ops);
 

---
base-commit: 760d2efe91a84363d25c1051a10572242e75fe86
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes
change-id: 20261104-submit-mtd-empty-io-v1-6a06db864131

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

