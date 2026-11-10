Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794316887;
	b=nth1GG6uYtZcadsjixEcIg1Lo/J1yRBnjDbM64+nI0iVONaZo7rr0oz5UPiMCDbzpgIA
	 bgprk5MHuPon2l/Kt5GEOBre0B0MaXPgqf5kmtBOIMojJ8INqe/M4KCsjI/P8vVeTlmto
	 hXOj4tBsTqkIal+HvK8ZBHM6PrH+BmgJP4IqxQrE7vqXzQggjeAF+EtIHalpALB29+Gy1
	 m2ihTYE2fe4AzEEBJn44iRbR9afz/9hPXQosA5oUYWgVkaKrswLSJ8X1kOBKHmYZloLwo
	 NWM2dX3mL7AFIP1Ox8gMb8b5vdCEiFDV5aMifRGLUWW8y4ZZI2roNYmZC8i6mcN0Gag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316887;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IIzXasZdl3uuF8A0Q0l5RjhqjxVPq2XhnRyfILIPfK8=;
	b=o9RCsMm9H31gbBwIMJiUCcKaqv2vSc6w5jYmrsQhbidpKZueI5pIRNxTaAVsSXMFR56L
	 8XIsGT4Q3S89oP/ld2BTICv0k9F7ZtAR0K6U+QBtGt9GXr6EvxBtHtHsrIV7uMsBdL007
	 48lDTBpA/BudWfBvmt8HIJ2lJlRrsl6tgQxUO/cRVS5hMHgSQmIDsL/w92CYyJ7G8Dfon
	 iPHXT1bkJf+nSWK25GhGpULagg2MVG6bESEGzgoK14yMgbYQeXGfh188AacAgtwMy13bQ
	 55FTbnSoqXoiDsrZNwMQGj1oXVVcIH7TF1HxORtCRSfKpPNGb2GSjSVDL+X7iVDfLeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V1UKZCwp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="P/mZPHOO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31533606B1AE
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31533606B1AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V1UKZCwp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P/mZPHOO
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAB9tO52253399
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IIzXasZdl3uuF8A0Q0l5RjhqjxVPq2XhnRyfILIPfK8=; b=V1UKZCwp63kvPwhf
	h41rxT74ANn20jC0bJ7s5PzBJwU6CkrHC6q0sEYzYdGtr5Ek0IVoBAKlsJ4fMLnl
	1xGGn3OWdFrxgSaU+sHBh6jb3kVp94TeHjSqMQzdrJaLl/755YTrKYgWuXldP9pS
	HAQ+IsiMSSdaP9BiWu5osSt7prpr6d787+aQH+GVXx6eCnHrK821xTSxZI+vJlol
	pa0oWwC3KELJhfE69Ax1XTcDcW4+m5kSWESYFXKPY/RzVhnXh+5QCIeae+7W56iA
	2y92KF6Sl8OvEDOehmNz+dBoIdTTlBLb8uaKJJBb4aBMkoULWz2Sa0Ah0bTp0x19
	MDAnXA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyw48y7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:21:26 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b342ff3967so31148497b3.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:21:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794316886; cv=none;
        d=google.com; s=arc-20260327;
        b=jaDacHYSb46USxv+ZWu04Ifj/O/bJNFA6i1Zz9awgS6EHmXwJP+0haoOCltbe5Tr7r
         V5w6x7ybz0sO6Qh2cgmgHLjqa7ZXUdD4xcmV8h0c3+tZb08fLz95Kark9GmY4CWhhvNb
         AqlfGQ7kJCaLNJ2JShkuMxRHWOZJ1cSrzlrElwHt4bslO7jzouC/Qgxu4NTuhqNMqnrJ
         1RD7DDjPs1n6EYqD7SzvWK11gP8VsGpR3xgwHh2ATw9OTj6NezSd/6TGmbL+WnLWdzRZ
         6ZvzVyexFir8zzJ3S28O/dC03J2pQAooNKbxRgS/x8MYQ6NyuGcioO8/nDpt9QU5wLlW
         fAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IIzXasZdl3uuF8A0Q0l5RjhqjxVPq2XhnRyfILIPfK8=;
        fh=/wlfNxzKQL+LYdI9eJFY43Pte+NS3IjeMKoolpZsddM=;
        b=C6PgsslGtN5BrP0vAEdytxpSSqY7gVpgI61U/v08QM4Slq0IDV5oWsBe/hEuAn5AKE
         pxiJc95dUswDuRHfUpAIog6UNdOoRBMZALxwS6ud38i9aiuPsYufPeEwouX2Zsuqs02N
         s+9atCiG7MT9bOuZp1i+Ud1Z7JYADwP5L3sCxCQ3OZ1ab7kh7yDmZND0Y0NonqSKi1lI
         8XDXZfRdCFhehvTVtU6Jig3c4F3S5MTxOzneEE6FXivm52NLrRPxJh4t/EdcxHIRkGQJ
         clTQS6w6qa7QcbeG00AnAfUXMcWN6qiSYzGhBH9Jyp7csrOIWjuvWjGJMJhXq8uYhwCx
         tMEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794316886; x=1794921686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IIzXasZdl3uuF8A0Q0l5RjhqjxVPq2XhnRyfILIPfK8=;
        b=P/mZPHOO45ZLtSNxsW+6+zOvv6LIRH1HnF0/rtBItZpifLNA9MLu8xEsOeSwcYp4XG
         6Yqi0QZb7r1cSpQ3TyEhyVEhdY3SpK5CGI8jLhhvuu7L5fcR1DLJ4w9oCGQ+gvFUioyK
         p1qfg25zEG7TqAR3TRZvxk7rhhpjzeUyfLX8cvHcx5TSUjxMkG4rUWSBEHFf/9VC7jPv
         AHcovPYnDl6ToMbqkBIaw3mXRzQDPuMflciMcqxG8HkNrVWhD9KZwO0oiIGk1kVLPe+O
         zAka1Vi1QQi/2TEbBzTkW04yI51hJ/cArze/D/s3h53WLIR4a7yyeJ18ZMDmaJ3GUT3F
         bfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316886; x=1794921686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IIzXasZdl3uuF8A0Q0l5RjhqjxVPq2XhnRyfILIPfK8=;
        b=H42abi8Qy6+TgmmVZZ1dC+nW8RIi9bfWx9QinMKoVdp4y/Z4Ja+N24IU9Zo9DOwRpz
         HfnEsvHO57yg1tCPlQLS0JxCSbqUTlxDBu2G+p+UHl1m6lJoktCc/EjnD9amhyGzb5dj
         8lryVALzh0PloQ30FSCSUceqQ4NxQZI6ZeB/ZyuL75+DmD02GEKhGj9mj/f1exFIxW3L
         uROK5ZodjxOcznisceeBUsQL9anw0RwbFCK7I4TW3sQcy9p4LswWmguo3HczWnOFGeO6
         2/BkIzZVYdMaxlcLNUqM4ipOhOrOsTJ41TJGL1cNCvC35i3suAfuDJDyv7aL6FguTij9
         WEMg==
X-Forwarded-Encrypted: i=1; AL+hErE4cEWBHAS7k7nsOLEprNaMuwCMgeKGt/tAFk4nnr2DL9ZgE+XGJbVgx3DaXJH1/vZwA15SHmw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+98XW1imL02fCYI9U3xWA4G+8HUXIEj/liHGlZuQ5t5AOwztHL
	16M1mNLLdtSPNHu9lmf06QzQ+ELBQohiOIx/ErcMGqkX+V9FfvAXOqL5IJS77QFEOKcCff93IGB
	KRes5ZAdx+rZ2xFqHqsUokD/7CHFdwIBkhLn297nKNLfbKG9j3FZBxvkbRN0Accc6ISJHVDbwUT
	hYnRaDxcMt89yYzxifEqhw2DEfb1bwrao+zw==
X-Gm-Gg: AYBFou2kB+cLOmqMh4CQG0uKXExS6+Vw5MXjRTh3iWVbKtrFwc6CH1ofyMa+KJHyqdP
	m7RPcUE7vI5xhFfdWG9wvBmA26gHHdB7sbkbqqGOmyEdGkBanBRXaWcxAQHh9oYVOdp/9Ixhv/U
	4O6SYPB7wZ2+H+oF23jIynxs8saYomrDA9D9DWLUosY0qYc5/bPcwJMf+I2PEXrsOc6ieg/3bri
	AqAee0yku+pSkpdXtsRbof2zu0UMz9cY3OVw0ky
X-Received: by 2002:a05:690c:f04:b0:8b3:615b:71d5 with SMTP id 00721157ae682-8b392be3ceemr13387597b3.107.1794316885528;
        Tue, 10 Nov 2026 05:21:25 -0800 (PST)
X-Received: by 2002:a05:690c:f04:b0:8b3:615b:71d5 with SMTP id
 00721157ae682-8b392be3ceemr13387437b3.107.1794316885060; Tue, 10 Nov 2026
 05:21:25 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026150345.284404-1-g.osokin@auroraos.dev>
In-Reply-To: <20261026150345.284404-1-g.osokin@auroraos.dev>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 14:21:14 +0100
X-Gm-Features: AclHuK_f3vyqMLgyBVux__eXfDzVIlzPHxEDHotsqfEZeO9lB7Q4GjX6bk6lk-o
Message-ID: <CAGgiveUr_1OX3qvq=kH9sdVggtgK8LyiSF5KDtCfGwqdxkRXew@mail.gmail.com>
Subject: Re: [PATCH v2] tee: shm: don't warn on oversized request in tee_dyn_shm_alloc_helper()
To: Georgiy Osokin <g.osokin@auroraos.dev>, Sumit Garg <sumit.garg@kernel.org>
Cc: Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1MyBTYWx0ZWRfX2YiuS1QzQS1/
 sMaKro1ztYQ2kezjlDfkc68bc0JjddzIqvGg4ZgEphLBKM0GPIWsy5ZE+OMXsN0dgCPzXf4UZtg
 uiJ44YYIGw2ZBV173/4/l8XEEyZedL1E3Jm0CCC/t/8n3lFCDaCypNPVk52vAmcprGbrSeCNI8X
 Ovq9ZgE8h5VJ+ZPceAHoilaHbCJFI/BthsJozuxf4wZ1du8PR+hsA2Kfv35nqOW3+AXr5cYMIx5
 JeeTknPiPgScerjZDUGDHh7W0QgA00zp3oEMP1vi0UgbyfnbLB9PgFWnoDJ3NtY173GGM3zLazu
 Nbn2HnKQ5tGxHdwB7bAgdGrvtLb1rvvKhwD/eScjTv0tqQujELFYrkSk7lhGQ4FUzRPkfUGrjV5
 j5NQ8n07xDRdypDtsD4d+aMNeo57Wc1psmp5t848w4Ub3gNDj9nSaEnZwQ5F8uKHr2D97r/0pcz
 wgSXkZp5QLEgk+RrT+A==
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6af31a56 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=HH5vDtPzAAAA:8
 a=Uqf-NjlQ7lL-qC9IIjUA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1MyBTYWx0ZWRfX+M5qu2JaFlR6
 dUG9sgiT24lv0T85ofQOdQKtyLPzH2V4ASMjaomHtjj70wiecuFC1aRt/VTEppS6SvP9s2yoops
 1GwX8J8IKI1bYfKSbLacLamOaM/QDi0=
X-Proofpoint-GUID: yVHKcsKcIZkLnpHu03QfWr36sm4I707V
X-Proofpoint-ORIG-GUID: yVHKcsKcIZkLnpHu03QfWr36sm4I707V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100053

On Mon, Oct 26, 2026 at 4:04=E2=80=AFPM Georgiy Osokin <g.osokin@auroraos.d=
ev> wrote:
>
> tee_dyn_shm_alloc_helper() passes the size from TEE_IOC_SHM_ALLOC to
> alloc_pages_exact(), which needs one physically contiguous block. A size
> above 4 MiB (MAX_PAGE_ORDER with 4 KiB pages) is more than the page
> allocator can serve, so it trips its order warning; on a panic_on_warn
> kernel that is a panic.
>
> The size comes from userspace and the request fails with -ENOMEM anyway,
> so pass __GFP_NOWARN.
>
> Fixes: abd135ba215c ("tee: optee: add optee-specific shared pool implemen=
tation")
> Cc: stable@vger.kernel.org
> Cc: lvc-project@linuxtesting.org
> Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> ---
> v2: Fixes now points to abd135ba215c, the commit that introduced the
>     unchecked allocation; cf4441503e20 only moved the code.
> v1: https://lore.kernel.org/all/20261026105209.161195-1-g.osokin@auroraos=
.dev/
>
>  drivers/tee/tee_shm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daa4af1..8b117d6 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -352,7 +352,7 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, siz=
e_t size, size_t align,
>          * and there's no need for any larger alignment.
>          */
>         shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
> -                                      GFP_KERNEL | __GFP_ZERO);
> +                                      GFP_KERNEL | __GFP_ZERO | __GFP_NO=
WARN);
>         if (!shm->kaddr)
>                 return -ENOMEM;
>
> --
> 2.54.0
>

I missed this one, confusing it with the other "don't warn" patch.
Looks good. Sumit, do you agree?

Cheers,
Jens
