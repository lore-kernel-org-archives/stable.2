Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211421DF73C
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429254; cv=none; b=lReWxyVNPrcxDr4smbQLgHLCq0hNtTMdCQGp9PGi1AwQXfvLGWrFelKhWseBri8mRFuxVSK3vLA9tWQCUZANh9aDxwEnkChoK3Xgy9GqfbLx+o+2xAn0/scCVCj9jvjJ7MUYPGsOW7VTjrAxFh1zQKCLQQ2UYP3fNYfBEeqavQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429254; c=relaxed/simple;
	bh=xoZx8RO1JgKb4KOJkIsXr8a+Y0iiGh5oAeIjbm5rPIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erCOM7kYDOrf310+gCeJ3Emsvxh/vkQRykL/AVLspG+eTlUiJ1aJaAXaAeNJKI4cAxxzDc1zxw+OaXMPBIbC8rcYSJVwxFf2JhDxT/WqRF7FzhhjRlrFNQKnrRJ1zWURmtsepvXkusoJ94kDRNsu3gCUj95kzVQI25tlwVOqH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Scc6U9cJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Scc6U9cJ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so6879324f8f.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429251; x=1781034051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Frm7yzfjQmQ0s/P5aAd6XoliFRyibz6oy5ir9ZFIkF8=;
        b=Scc6U9cJj81i0U6CjC93Fy5q90MMWxQkbUJL/bwsAlIfjUezBEuhOACOnpZzCK1I0f
         +3GxSNtW26pdJAV/pEg7fR8zdhDPMTQIioAb4tmWiaHiET/+tJHduMzzvLwbSLxEgvZq
         il48Jvq9MvVtR7Z+zz54IWZIf0XZH64YIDIRxHM8IDjo3MCbO5lpoHgDONXueTh5la0q
         ZHnwrzmKXe8s5Gb35U76tlPjiExQXjNRhlzuF6T3/uz6d4xdRv9dEFx9rllDNvinJHY/
         uj4Cv6oHOcJ+FDtoUK5A4cSlHDijgvmLAjxEQ6ADV2XigVtXORBSscpF8st96OJm4pa/
         WwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429251; x=1781034051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Frm7yzfjQmQ0s/P5aAd6XoliFRyibz6oy5ir9ZFIkF8=;
        b=fxcizgg2lI1AZvYD7YaNwxPvQVVbZbIU6oga3iWfXCVE0CDx7cX1I6K220PThWr4Ca
         KNwZvopeJPsPbssfTfD/e6+jbc8KxZP/d65VKHjttfuanep1ku6A0GLDdWScBsQtU6gQ
         4z9eIHOMepes7TGOR0Hzv3sYu3bxX1QmuZJhESLyxm6fHyeIJMK8E2iIexHDEo8FhGxc
         J3Z3Lm43tjMd9Q3VblqJYFCdGtkpef0NbyW4tE3m6z5wiXHR52EY6hTcxbPYXenki/id
         W7gy+U3aKvHsdeJ2zwIZB5s0QJoclkFamwgNGKonvW8yLNVmNHTMcNPlIyaOQLTVEfZQ
         oFfw==
X-Gm-Message-State: AOJu0YxPsT2iJBAfmckFUXQ6k7Tb1kme+kzijr1oQfJ2X3zegB9v4kIs
	zXaPUP2WyzFtTanC9BhGN2uD2gHZBBbpsUnP6sjt/Ojy86JsRkdsbxH5pvP/HESQ
X-Gm-Gg: Acq92OHyihzryQ3wFfUhY8VN1D9ovAT2CahVv98VqJY/w3clr19i83S/5SEogMQXBdj
	V+SrvGGiYQqg9G15proXSyYM7bV6b99xda7PkOQinTcr8fPZuXc2uGqmpe0TEMgjuRaTW2tFBp/
	4BUFThJKOf+93Z4tvVF4XtFKtfOhBjFzABuoWpAtUM7NFeEBTu1iMr6ACFjyC2Ojv7AgM+xrhYV
	7HBcJ6A0efwzcInz83ZxMH2KJ6mpyICwAQoPMJu1FegmSFxAeHb9m9svfHBcyuTeccsW/bdS8Zi
	jTxfufpeQmZrUIf1ircalbrmjYX3MwuyfrnUj+xxY577bsuD7uRZPuNesNE1ZEZGY5sL+zjztoq
	5RYrDxyljkRKUYdV5cemKR9cASWSLA5FhAzhHg24RXsS1G3KGA246VwEfNQmFLLzZT7AV2+Xt+o
	NAXtP1uRoaOTD48oX8EDJM4SH1airfuIrmRjahwKq+asbasOr+8z0Jw07q3dxZTFobhov17d0DJ
	dELmVTG7bkZ6oIbwqywUEGANMkhzXtzMnTidXZU0oNLv9JUhxZP3Q/7xxcfhqpEdtj60oqPZdy+
	zLgXNqlh1EW2qloL4PM2UPMuuhBaXLPQLBitetEDUTXLvSAurhXdGA==
X-Received: by 2002:adf:fb07:0:b0:460:13db:4a03 with SMTP id ffacd0b85a97d-4601f4ea1f9mr1068164f8f.7.1780429251412;
        Tue, 02 Jun 2026 12:40:51 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm1521458f8f.33.2026.06.02.12.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:40:50 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:40:48 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y v2 03/11] Revert "selftests/bpf: Workaround strict
 bpf_lsm return value check."
Message-ID: <547aa41ae19b2c72162672492c60d3246b62a53d.1780427227.git.paul.chaignon@gmail.com>
References: <cover.1780427227.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780427227.git.paul.chaignon@gmail.com>

This reverts commit a1914d146622 ("selftests/bpf: Workaround strict
bpf_lsm return value check"). It seems it was picked up by mistake.

It applies to a selftest that didn't exist in 6.1. The whole selftest
was then backported as a stable-dep in commit 45108a7b4866
("selftests/bpf: Add tests for _opts variants of bpf_*_get_fd_by_id()")
(reverted as well in the next patch).

The new selftest covers the bpf_*_get_fd_by_id structures. Those don't
exist in 6.1 so the selftest shouldn't either.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c  | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
index 568816307f71..f5ac5f3e8919 100644
--- a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
+++ b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
@@ -31,7 +31,6 @@ int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
 
 	if (fmode & FMODE_WRITE)
 		return -EACCES;
-	barrier();
 
 	return 0;
 }
-- 
2.43.0

