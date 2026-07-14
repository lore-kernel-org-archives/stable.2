Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DB3F076E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018028; cv=none; b=YkGHDUbHKkWdy62B/VAhLk0GnkW3r0eENbLerh/NxD5owZijcTtZI3jbpF02jMrwDdsecw7MGk1QO/LeDDeVDSWawrJIqKdzPLRASNdD3NHedgyR089BUc9SDnXGl/GxEGNc1C+ye4t+VP2n620wwS+379eLTAYDYUGoP3J+1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018028; c=relaxed/simple;
	bh=IHW0jrVYKirRz4xFnRAvekmWCpqi2k7RyAf7Y5W4PyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1DrCpN+Pt5Pxo66C6IEhWxD+yLp2MxdNj/Zz/MUsOMpCnJXLqp6ZdcJitjl+wEyHIsQ9eka/ds4u3mr1lZrglhD7Z6h5fpcBMp9bH8fTcsxRFPQ3oFSNa93CJ+BNctgXtyQ3YIORvug5MCL++O5D/8ls3fbVSeKjtwgT8DK1Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRNHBawA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRNHBawA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so5156025e9.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784018020; x=1784622820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dN43QeMKt3opRlURLs9WAJqq1Kw1gcGP8C53HZV1wz0=;
        b=ZRNHBawAzRsgDKjWIYbkX/L1AqJpGi259NXywqFklR5avA8/pAhNQPKxfaa7liKDGY
         NV9ytgt92T/KO1vMDsKuWiBcWT9AtNz/q4ge3CeGVXADTLhavvQiF9NVejobzMQizcy+
         OSYECwuCUW4yzY99N0TT7xKej9FCV+CvkR+uyeaFsaQupoT92k3dVzY9RvibPF+ZrP+k
         PnAoa2EWiPB8TPl/VQMTjpbig2UNMZ7cS8uNkIMfR+3jOe8IBchyDeaoSngsoWYBhj9N
         GKF0e4AZ0teyjC1rpeqSD2d/+7s9DVcmuPxCqSuEKn4MaUjLkoWCwiF302XoWJHMFDu+
         PJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784018020; x=1784622820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dN43QeMKt3opRlURLs9WAJqq1Kw1gcGP8C53HZV1wz0=;
        b=DUBL4K3t5rWa41XzhIQQMs6I/KvNZw2+P4hWvXk4gKmNZ4YGYvL6x9rjT6FMWSbh/L
         phNjpjb6uEI1GkhhL154FAu6Rg0xeQD7YvWIx8dWwp/VHqpsScJ94cH4R7eMV1ddvFFK
         cXbAeQEWR6dvfTY2s1lyzXTTjXyeQ0P6JEVZq/Il+YgtG0/kR+wl5oWDeq9Nfzy9xESf
         YAhZ4jgduPQreWAgGKwWa8oO9hZ4jWXC6LpBDnHfdSbEIHsRgF1onBVlStisq/H5Z9KL
         XqM5E1gM5emJuglrdIAAah5Psf0mYXL5g7RiqWQNXK08e1Cfu2nrGM+AOuqeZmrXqdev
         CdlA==
X-Forwarded-Encrypted: i=1; AHgh+RpS4kjMOduo6dLLWFl6Ap+HCVBQhZ4TS7KFGyK62Q3wBMaybj3h4jTqsJ7vVU2Ytv11h2d/Z00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91W7+1aExkDuO1SvrmwiH7LKLlMxEJT7F8iZYc+wOU+lhhDsY
	EoGO0UwH6KFEXwa/dsyiNAPnbK1b0ZUWtiItvUYUI3c/oQe065Lyv2z/
X-Gm-Gg: AfdE7clpElD6wgWBAf66pn7DRE2sQn+g+QNSSypJBGDNaaxZT4PNvc4KjTzN3IFXSmH
	0k1DLKyuf4YHqjMVdqzYfdaVNSenVLo+QfWVLTw1gDk7KzWssBbSeMvHvZb4ZGqMs+7ORKRAxna
	ujtPT3XKnv6/ji/mZtlzOEL6QPM/FUovwxNLCOvoaosBxnqLhdTsb2piS5BMsKLC7Ly/9d+IXeF
	M8ke7THnclTv8v7M0yPNq2QNGAOAlME4sOZAhk/Gsbb9R6WWf3r/gVXhuQGuSWNpkzJUcsgZFKw
	GQWbLimr18CBx9NTCwcsj0FMmv3GUrH7vNucD6SYF7o7Mn4I50b2vIVFG4HZ/DvoGaXdiPrgmS1
	07oqTdbzgReISQ2V5WIVYHSc2QbRCmbpeRT3mefPwknC4xWT7k4mIPIxMzltST9IoV0Fgs0bUPc
	T4hEr6UZGVPbMA4Ha0FDgBllWT4j6LWVnNXg==
X-Received: by 2002:a05:600c:1392:b0:493:f753:24e8 with SMTP id 5b1f17b1804b1-493fed59338mr109265975e9.6.1784018019335;
        Tue, 14 Jul 2026 01:33:39 -0700 (PDT)
Received: from localhost (a89-182-201-216.net-htp.de. [89.182.201.216])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4950a33a926sm52933245e9.15.2026.07.14.01.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 01:33:38 -0700 (PDT)
From: Sergei Litvin <litvindev@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: ojeda@kernel.org,
	nathan@kernel.org,
	nsc@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Sergei Litvin <litvindev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] scripts/tags.sh: Prevent binary files appearing in cscope.files
Date: Tue, 14 Jul 2026 10:33:31 +0200
Message-ID: <20260714083331.69482-1-litvindev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CANiq72kHbVQfNrum5D2a5sCd3mFQHNtigrQxP1WW=YcggxA=WQ@mail.gmail.com>
References: <CANiq72kHbVQfNrum5D2a5sCd3mFQHNtigrQxP1WW=YcggxA=WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When executing the command `make COMPILED_SOURCE=1 cscope`, the resulting
`cscope.files` file contains filenames with the extensions *.rlib, *.rmeta,
and *.so.

To fix this, modify the regular expression in the `all_compiled_sources()`
function so that only files with the extensions *.h, *.c, *.S, and *.rs are
accepted.

The issue has been introduced by commit 4f491bb6ea2a ("scripts/tags.sh: collect
compiled source precisely") which implemented the parsing of compiled sources
from *.cmd files instead of using the "find" command.

Cc: ojeda@kernel.org
Cc: nsc@kernel.org
Cc: nathan@kernel.org
Cc: stable@vger.kernel.org
Fixes: 4f491bb6ea2a ("scripts/tags.sh: collect compiled source precisely")
Signed-off-by: Sergei Litvin <litvindev@gmail.com>

---

This is the first part of this patch:
https://lore.kernel.org/lkml/20260602121521.11650-1-litvindev@gmail.com/

which I have split into two parts, as suggested by Nicolas Schier here:
https://lore.kernel.org/lkml/akVkIrcpNxZrrfii@levanger/

Changes since V1:
https://lore.kernel.org/lkml/20260705175936.4653-1-litvindev@gmail.com/

as suggested by Miguel Ojeda here:
https://lore.kernel.org/lkml/CANiq72kHbVQfNrum5D2a5sCd3mFQHNtigrQxP1WW=YcggxA=WQ@mail.gmail.com/

- Add "Cc: stable@vger.kernel.org" tag
- Add "Fixes:" tag
- Add missed "Signed-off-by:" tag
---
 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 243373683f98..c9dc2763a505 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -100,7 +100,7 @@ all_compiled_sources()
 	{
 		echo include/generated/autoconf.h
 		find $ignore -name "*.cmd" -exec \
-			grep -Poh '(?<=^  )\S+|(?<== )\S+[^\\](?=$)' {} \+ |
+			grep -Poh '(?<=^  )\S+\.([chS]|rs)(?=\s)|(?<== )\S+\.(?1)(?=$)' {} \+ |
 		awk '!a[$0]++'
 	} | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
 	sort -u
-- 
2.55.0

