Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793268721;
	b=RRI+/ZeOeJb9Tqgz2asgfE7jSL7CUZHd5c9PTd/3F0dwEhRqHS7L64FE5sKCHeva8oZX
	 g00rNosb5u6wC/eQZVDGvR8fQli52w7Eia4IgvtowC7abxw4Zzr7RLh7D2pIcGVVUbPC2
	 Q0nTn3nJwmKA0HoD9Hr4MXHxNf5MTbNWQQd9wX1mmMnbEAD2TDiA+VloM3QKFpG0uGii9
	 OGToBNrEf0ShVinHgUy+XtKve+JtAi0lDNJX9SuM1RZwwkTxGP1JHbF7ZISU5noJCOWZi
	 I2C045qzGDY4PQZBuKvK7P4ExOw3aowf/kXen77J26baU9WRWCPi586agPNwWCFurWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7s60NUUwdXZLJ5wOWPuuDFc73pKrbdpj75fVNegY9N0=;
	b=ZR3rC8NgugoBPPrO3sJY3BJtKyRj9yexod7gEvsQVSXzMhwALL+2U4erWtRxuXkvyIWm
	 2yhCt+p6xmfP+zplTcroB9qFlrIol86dwWGFJrgAnTUn31fR4aPZ3gCsTmmICzVTd7UTO
	 E+qiFtwTET6Lf7ixAMmA1WXkVA3c2FRIxKFq0Kb+sJMVl+rWJwrA+a5UBcuNNroCSKoAJ
	 wCr7Ittun7xgkOxmC5iF/cuNn54A4L58MsfvivqYygNgx+HyCJG2vNUrCqls4PzwDYPsN
	 5fpzaMmM36gTSia2DVZoLBRX9LwyJXRBHzMwGUd/sP9WldrYUYqqzhl+YFB7ood8vUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u2sBbzu2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CAD606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9CAD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u2sBbzu2
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a18fc7a38so3919876eec.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793268720; cv=none;
        d=google.com; s=arc-20260327;
        b=lheW/4pXw7qvfLOZgDfSBpT0kXWE4jCiAEPBNsOMzKwSQFn/1M0UilO7t5p3tSarTg
         i0/NrOyCmkmqsVLgCHQkMci6aEBgQ6sMWwD5S21ceohqaLeP5wdKxtnjkuC5NXo52jmZ
         hOFnMh9qVx488YTURIb/clyo+Io+U4HtMj/qo7H29puKAmO2b0EnvvqcILyZ8OeiscVv
         A4e6+/U3w1McGj3wUNrlNQl32sYxPB9jGXsXnbbghi2RF4U8Rhcd5G7I1Wnl3Uapv5mR
         n7dvKmoTYnjNEbVROzexsXyHRw1lO4MzwIvkUUAcBlraxAbchmYkYYkL0bY6lRpW4fIo
         yDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7s60NUUwdXZLJ5wOWPuuDFc73pKrbdpj75fVNegY9N0=;
        fh=SqYcGQs/qJ4I6MVQ82Ggan/946P4/iZ7Qa+h10I6hxg=;
        b=SpaGAtDvaPi7JBYmlYKZG+XzyeOZzFGlALg44+eqE3LtQxF7X46wTOCKBdJRN/1T/x
         q7R2IoLbOqO7lA/LRjFQQ2NGR+vZsNmqTH4OoCEGQoNbi693dLrt1M5pZuysRK5qYOum
         xUQQMuOhePtkPhjCTM0SmooNJ32/MvVxiqkhwQ+xW0TJR7xZedisO6lFbkNm5m1aHsCU
         YVwiIQQ6TrybAbcDBtjjuokmWbY/GOq4v7KCHD90sZBE/prB9YACLZNO8LXJU59J5Y5X
         1plbyrxirb1yCp7imVMaBrIDw6ozkJU9OaAGGkmBIdP+oslL9+yQTDxVni5I/OkoSg/g
         1VzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268720; x=1793873520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7s60NUUwdXZLJ5wOWPuuDFc73pKrbdpj75fVNegY9N0=;
        b=u2sBbzu2hkGqyQz96k0avHJnOd0ePQgrM+7rXIY5CaAiiyZJB7fbos+LVo4+Z+VJie
         mfAk52msiWbRDYHSp6K9F0r3vBVAu42VWJJcIswYAYEyddym4KipIWcJYlkp0v7JFUHa
         k3ysl41ONGLKIb+TkwkfXEuupnVYF5//5j061LJHXetcAlOvsUOPH6qQWPgEteyujjbk
         j5jaHwJArz0QdE8bFA4OOAr9Ey0Qm8lid05av05lDTQ9eH0RF0QJbM7I7Q/+KzxUNVQ7
         KpVI1eN/Yc8p8K+7W2df991+0sj/x6HGrbPlXbQCBSgjIoZCtd4sLnyYEm3nyAEBrykc
         JUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268720; x=1793873520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7s60NUUwdXZLJ5wOWPuuDFc73pKrbdpj75fVNegY9N0=;
        b=swcq2Q+WODnYo/1ldIOLqRReHcRD6wdMI2OSHS1Yu2nZKjqnLUQGmkuOrl7t6SY5VZ
         lY3aFZUscvoLpGtnMuDTDVNB4lbJDTZbd6bpNsaK3TRhW/fgtd0LoBp3knjG9RHo48xm
         cTGl4P17po5WMiXwWX5YbLmJsUzGCJ3OiB955hdjB/u5QUdvA6wZM38mnAUZYDeTsBje
         z8NfVOEL9u+ed5knhwYshAi/PAR8CIBjf7wr5QCHdUjHWRiUPYDcKALxKrwbUKEnII4p
         NUrxwzA9wGX4WA81OilSB7trJ3KuDwe3mIKrmWZqpshMG3ZXYva5LiD9DJCrfOnV2wUD
         hTqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzukys0KANvx9qFaCbSPzXsnCgVsE2pLE76fzDAHWQ3RpqmBsykyHeB7WmQRdp73aPBpERBuLk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdS4b5BH4HAUMc2vL1XG0QZ/VCPKAZkcqYad9Akhh878Q6Rz97
	UjhwRQa5aWKNor11KdSgAku/PpqIbmnXkzKpchuNeHb9u6ryFKb4VlaXlJMbpj9gp6OJUs6RBZS
	hh3/1tq8dmigVXdMcv+mX415kF7X7k+I=
X-Gm-Gg: AYBFou2DLadpCptaY2CDleWo8xAcDlt0ZIgVrI0+89I398SbUlFU0bZBJy0xTOfT984
	z/dIxekUKrdPmoEyDsVL8CQ0BpOoqyC61YZ/DOQyUelmIiA0egd6Ylx9HjUJjm5hcMzqQUdOv3f
	fsvyAaH/uFmVWbYshYxtsOHg5nCId0B8+xGLjrDiZ5QhSKEqKIUWsCANPgIIxnfxm7YyH9AGqRs
	zd6/8DlH1lKpfL/NxH7Ueq1jlp7KBrcnm8SWiNgrBbQ6+AJNF56kOVZsYwStyaj4M7ooPewJlkf
	W1jI0daEQXZFRPTupCIcl96I7Nnp8zhCa2EnUDZki689jp+VK7gtD8c9ddzB6h2qyqBkSXJUXpr
	70UwkRI3OusyhG5wxdWRZtfAeaXq5oCT3Jq/QO7HTbDqj0j+5h88nDYnHs3zveEO0YT7jng==
X-Received: by 2002:a05:693c:87c6:10b0:366:fabf:6273 with SMTP id
 5a478bee46e88-36a20459a30mr7592769eec.22.1793268719830; Thu, 29 Oct 2026
 03:11:59 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
 <20261029-upstream-speedo-t114-v1-2-81457cc9d94c@tsv-stahl-riesa.de>
In-Reply-To: <20261029-upstream-speedo-t114-v1-2-81457cc9d94c@tsv-stahl-riesa.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 29 Oct 2026 12:11:47 +0200
X-Gm-Features: AclHuK8mutFrWjpw6_PPdHUAyItvpAhM72OsxTaC6ggH-p4KNaOHRql6Fdiss_A
Message-ID: <CAPVz0n3TSeed-SgBbvsXtPJtx5CGzuYcruqOiKVaijBu2w+HVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc/tegra: fuse: Store Tegra114 CPU and SoC speedo values
To: admin@tsv-stahl-riesa.de
Cc: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 29 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:3=
3 Patrick Fischer via B4 Relay
<devnull+admin.tsv-stahl-riesa.de@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>
> The Tegra114 CPU DFLL computes its OPP voltages from the CVB tables
> added in commit 5aba939e80f4 ("clk: tegra: dfll: Add CVB tables for
> Tegra114"), using tegra_sku_info.cpu_speedo_value. The Tegra114 speedo
> code computes this value but never stores it, so the DFLL uses speedo
> 0 and only the c0 coefficient remains. For CPU speedo IDs 1 to 3 c0 is
> 2190643 to 3395401, so "mv * 1000" in round_cvb_voltage() overflows and
> the OPP voltages are wrong.
>
> This is currently hidden by a zero voltage step with Palmas regulators,
> fixed in the next patch. With both fixes the CPU OPPs range from 1000 mV
> to 1270 mV on a device with CPU speedo 1742, which matches the vendor
> kernel.
>
> Store the SoC speedo value as well, as Tegra124 and Tegra210 do.
>
> Fixes: 5aba939e80f4 ("clk: tegra: dfll: Add CVB tables for Tegra114")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/soc/tegra/fuse/speedo-tegra114.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/soc/tegra/fuse/speedo-tegra114.c b/drivers/soc/tegra=
/fuse/speedo-tegra114.c
> index 1e6c2b5be759..8bf1a1b1287a 100644
> --- a/drivers/soc/tegra/fuse/speedo-tegra114.c
> +++ b/drivers/soc/tegra/fuse/speedo-tegra114.c
> @@ -92,6 +92,9 @@ void __init tegra114_init_speedo_data(struct tegra_sku_=
info *sku_info)
>         cpu_speedo_val =3D tegra_fuse_read_early(FUSE_CPU_SPEEDO_1) + 102=
4;
>         soc_speedo_val =3D tegra_fuse_read_early(FUSE_SOC_SPEEDO_0);
>
> +       sku_info->cpu_speedo_value =3D cpu_speedo_val;
> +       sku_info->soc_speedo_value =3D soc_speedo_val;
> +
>         for (i =3D 0; i < CPU_PROCESS_CORNERS; i++)
>                 if (cpu_speedo_val < cpu_process_speedos[threshold][i])
>                         break;
>
> --
> 2.56.0
>

Thanks!

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab (P1988)
and ASUS TF701T
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
