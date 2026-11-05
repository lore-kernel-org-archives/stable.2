Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793892354;
	b=k2LLXYDfJA6HFsQrM9SDeATqnS2tihxXkwaqLYYJHHt3//OxDh9hhbfrmITudJP4bb10
	 54VE+CyXTvwq5HIr4EFQZjweW6mzLfqSaqzsMKblsvNmVqnvy4+RWWEFPBZnaF/3+/4LH
	 oqoit7JYwZtXyDeFOIk/sC72A9sdBfE3eVeRRIPJf81ZRrAOxuJEp/CbTieOp9djBHed3
	 vVPjYag94IooEZ4Z6wO9yMDfsagJrEmO1Cx6vI8RPf1hp+LEr/oD+5NMDdtbHFAU2G/M9
	 koIN2/eWvVXoPbzUpcziYTWyA3JUivFiXnG7G88pyVd15yNEZVSaEYa5kkbKbW8KndQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892354;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vjhKddhBYDjam7gmYzCuUV2TommKkjfbcHQoD1zd0pc=;
	b=dk6t20HrJmpIQreY97QhpRnClYi6hwDspRMMZRyMEHE/r6gYcDvZh872vYa0p6QGQmTv
	 XKeLGYrc/AEWjI0XbPBTTvutJND4lg0ffiPvU86Snv2eTrKEZQhEU4Xs2yPudwrhsI7oa
	 cqgs8UM1Kc7XknxCdT5kOJWO/8pHmrn0nEu3jrLufrpM9p7Guw6f/DJnyNbnpM/TLYd5W
	 qPkE1apft21hOjCINB//PoKfk7JJxiVg8FboE/KezqJKwyrFvct4g/JCnulPje6Bcxy62
	 gTJLVDUssu/VPrYbyOORhI2VxJEwpajDGGEdD0caZkLNo+Pyya/c7YVxv258K71OIHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WXgsHAIw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WLYXjjDm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20983606A330
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20983606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WXgsHAIw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WLYXjjDm
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQGHL2004544
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 15:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vjhKddhBYDjam7gmYzCuUV2TommKkjfbcHQoD1zd0pc=; b=WXgsHAIw4cd5PFjW
	lNmKFBgafI++UoKu7IynvRLi/wt+QVNg8ySrAgw8O3o35+zwrbp+bul4Z4PAN1Yj
	rjJKnkwqQkbm3cEIvFtNqVcN5f1eOU5pbJnrHNF7D8N5XYQUw2bpbtRs8I2TdFJG
	XpJh1UpmR+xQfx87Of4dPAw+VY2mcxDog4B90qKnrVr6+UWqjryVxh1SflOobBAF
	vH1fjqBhGQhjNGo0WMn7sRRzXep/lW3uyAXpRd3wRC2z9UUR2kiQV/7X0/KsmP4T
	HgFMnwIcqCDB5QW5FsIRrNjs0jkzBxl6B/yxQ4KKr9H5Isw4dfnFF30HR/xD29Kv
	F7jgqQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqpd1bhk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 15:25:53 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b0cd41e7aaso30999157b3.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 07:25:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793892352; cv=none;
        d=google.com; s=arc-20260327;
        b=mBanzlWjYjDErBerOfbFzOcbfmfTaHov7gKxKFqySNGiZm4dz1oEQUcB2HcgYZmHzK
         BJy7iuSKYXf7ONdfo4KYK6hUBrPTSr3vhufTsnxcWww+xu0FSUEOe7w6cv8coeJ/jCPk
         yDJ+driTcWgxWthf+VnnkBfV0EuYq9Nx2PS5GJW/w+6FX2rphfX4bc2Fhl7AQkRqUcXS
         RsXaHu5Y+BjKMOlFdTHJR9FKVKQuXcY4EZk5osudKFGQW5PmoRGcf1bmLha1M94El7v4
         lOdPcJfpGZWoFbf4lK8Mvo+0mt3BK9uIBIHb06J6zGomkgJYreXuhJHNiT6EEnNPxceF
         qL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vjhKddhBYDjam7gmYzCuUV2TommKkjfbcHQoD1zd0pc=;
        fh=wjCMkdoiZpweRsEbLyyj+MM5TkDMTnt5SgY++ChOvB4=;
        b=kxJyCbu0xQg+Lyw98at5Qen9OI8ru/35K6FE8UfHuqlxupi7xPHnFxIGmWvY/acSpO
         H1yGRz/hN4jjqjODw96SnfIca3wmZdeegVkjKECc1MiP4PCCVmklr0/x2IBtolJg/ovt
         9FG0Dls3xOJUgfCkBe1puPxyZO52YcGr6XcoueLikKTo4Id7fSZsUMxiTAFCYRUAMhqp
         4bUGykczi1AM3X2mZpkVUIwiSGymH8+tVhmPsn76RKLK4CclDeKCiQQ7pJpQsZ5sz246
         VqeL/Yc91J+miNvH8wBUVn/OH3+GHsHSGILyK2sXwr9qDf6ch5g/XOCmOCD8VNdqBSWs
         seLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793892352; x=1794497152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vjhKddhBYDjam7gmYzCuUV2TommKkjfbcHQoD1zd0pc=;
        b=WLYXjjDmgY+FqKjJ0Xw5kC9fA5KqmRDKTwoAizy2J0qvHSGOSnCMFx2KJGmO0GOtzj
         FRxaVpPyZ4swm0u4Cjbm8I6o+55F/0OArDAs+smRf2mg2hzIyElsQ6dC8V4kqeeiH4bW
         SOWthIOBEUO4sqfg1llxzTOL86nUndA2pe1lsDSfHLJShTM5E2pjH91LALww5TW7ZTxg
         rC+W0Ttfpq2A9PJHnMlzGdk0HJGHy9lx0L+rzycmHrsYE38KL4yzuyCITYXVY0rujdOS
         Aovil250B9Hd5zIhei2HxFjWRD84w61srxtntYZ9FRqeUQxcHnQl0Sj8uWtW1o/bJnus
         38Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892352; x=1794497152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjhKddhBYDjam7gmYzCuUV2TommKkjfbcHQoD1zd0pc=;
        b=elKoOHQIG6wyQuasZNLxJbNT2PAfsbSdxZWlqDYNI+V7n/CL2aMAKBrG125pytmWCS
         vAvAJpBoImqFUXwv0QHSxUoRhtPpzZRDqE0WUYPxJdVpGlFvwa2SbyKXidCZXh3vJT/W
         aiRPwcwte31P3y09D00osC4ALzsh6jy3zNHJz5LhkyvK2VSZxYhOph2vh3rDHYQc181W
         lEOSWgGmsCfES7eN2VLNojdZRFDEO+XyM02o1zuqpQiGEgxheu1367di6TKCMtQ8KNKe
         gwNHgBpQWuCsDvmivmwFDM3nRjUZDt70IDf8Yj44yKzjQNVpkdUUytjeVNkpnHgioEp8
         4dXg==
X-Forwarded-Encrypted: i=1; AKwUvBz46VeCiEv5IBqYNncvT3Sdrh7bcIcpuUWaRIE2feDaPP6nZWX0tUsxt8ToOXmx6WJlIhmai1E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1KfAW+oRlyGDljvdlR7khpbO7kwul8m+UGEOo8lxH32FHt3pT
	wiwljg/QQZIorv4g23s+98mjLqOYHUqm/31XX83YdxFwQcVZZf/jJV1QjLwoTqstETipSprdBLp
	Fsx3Vs70rNEwByZVb8qKIO65DZfj+sI3QzDPHYXuXhyBCDzNYBtpS73iYq9DYbF/3ysJV9CdLf9
	XpUp9d6siX179AyUhDQX3ZkAak7s+UpiDDXA==
X-Gm-Gg: AYBFou1N+8YVwR1DYW0AGrV6VqjS1cYowJ2iJjxh+1WZa/P+hf0MFbnTQGp9ln9Q1dF
	lR+suzgSrpRv0nyfOyNPRto2qifgeq+hlC0wJoOxxQhM/PkknLmjOLhCuu/jAtTTJvzF0HKoJEr
	3bgRT/TguWT8+kOn38R1EheFAWlgEhCRxxOG6RRs5G65Zt/TTAUa1S6ffXl5tT8nCr8mQ2xII1i
	YeSjuVmzsv02p/wTI7Fo2JQwuXiJrd2YKSVv+aE
X-Received: by 2002:a05:690e:12cf:b0:677:dc7e:48b2 with SMTP id 956f58d0204a3-67ba4c86589mr11693054d50.2.1793892352240;
        Thu, 05 Nov 2026 07:25:52 -0800 (PST)
X-Received: by 2002:a05:690e:12cf:b0:677:dc7e:48b2 with SMTP id
 956f58d0204a3-67ba4c86589mr11693043d50.2.1793892351655; Thu, 05 Nov 2026
 07:25:51 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023210238.551855-1-g.osokin@auroraos.dev>
 <CAGgiveXkWxrdeRYCxBC9X0eQSUAAxF5N+ioe3iM6GZ=pSqHHeg@mail.gmail.com> <auxy_pv57awSTf2m@sumit-xelite>
In-Reply-To: <auxy_pv57awSTf2m@sumit-xelite>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 16:25:40 +0100
X-Gm-Features: AclHuK8d8uq9ewtGZRQXy2A5QzI8YGszOw3YIr6_bJKxcDqcRh8qdQM6EdugmVs
Message-ID: <CAGgiveXx8hwsbjvHFHb7qtCOxKDsgOmGN7rCDVj0y_-uNyX4kQ@mail.gmail.com>
Subject: Re: [PATCH] tee: shm: don't warn on an oversized page array in register_shm_helper()
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Georgiy Osokin <g.osokin@auroraos.dev>, Jens Wiklander <jenswi@kernel.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfX7DFngXAyILT4
 RXJkAax+x/4ZSz98gTSclethx9Fb6s97XfSru+HvZor6O8KvT5RFoOpx67/vk6f/vQtpy/RIjVm
 UAO3lnNalCAkjYFOe2uaQgoLgJZVjjg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfX0IB8aNyC2ozP
 gSiQj2jZmp8YoCKQDFuKL48F78FctNsMGHdF2a2qNzT7R2mLX++3Yc3WKAxE00zkZdXgfoWLIFl
 PuGyFTc4FpZ4u4mHaM/ETZdnSo164100gDEmRCPeRyzFfXtHHRRsHXRacqDi25q8R+lK8NagxcE
 aqBHtlrMxaRIeJCLc3cmCmety778D2MlA4XiJvQXehFzoOWNNX/Osxu8tBw8+T916BXt8m7iI2l
 AbMoWEOHIyXI7BjnYFR2hjKo0RT4yPHZZqVjKt3GAbzBWmEUaUZc0qi9SgSqhrOU4ef4l/RK7gw
 ML6EcAwE8RECIOaUJxCQARbvZicL9y5j0rwrj23tW8RynM+5OPjYK+p2jDwsDdayDC9/Cfl31Uw
 4kJ1ntJPwOdYx/B3UpDiRVAydrqDCvZuuA+ByqnYeRjhCiO/C7EeWD7COROWUtHYuyDdbqDA1tD
 Yu/+X5YlPaUaVQWX/BQ==
X-Proofpoint-ORIG-GUID: PdDVjA8pCpLmg5E86jQj7rphiPYXGish
X-Proofpoint-GUID: PdDVjA8pCpLmg5E86jQj7rphiPYXGish
X-Authority-Analysis: v=2.4 cv=Y5JtIReN c=1 sm=1 tr=0 ts=6aeca001 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=HH5vDtPzAAAA:8 a=EUspDBNiAAAA:8
 a=t_EgE2yqlgOat-Z1zJ8A:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050061

On Thu, Nov 5, 2026 at 1:13=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Tue, 03 Nov 2026 at 19:34:08 +0100, Jens Wiklander wrote:
> >Hi,
> >
> >On Fri, Oct 23, 2026 at 11:03=E2=80=AFPM Georgiy Osokin <g.osokin@aurora=
os.dev> wrote:
> >>
> >> register_shm_helper() sizes shm->pages from the length passed to
> >> TEE_IOC_SHM_REGISTER and allocates it with kzalloc_objs(). A length ab=
ove
> >> 2 GiB makes the array larger than the page allocator can serve in one
> >> block (MAX_PAGE_ORDER), so it trips its order warning; on a panic_on_w=
arn
> >> kernel that is a panic.
> >>
> >> The size comes from userspace and the request fails with -ENOMEM anywa=
y,
> >> so pass __GFP_NOWARN. kvzalloc_objs() would not help since kvmalloc
> >> warns above INT_MAX as well.
> >>
> >> Fixes: 033ddf12bcf5 ("tee: add register user memory")
> >> Cc: stable@vger.kernel.org
> >> Cc: lvc-project@linuxtesting.org
> >> Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> >> ---
> >>  drivers/tee/tee_shm.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> >> index 6742b35..d539988 100644
> >> --- a/drivers/tee/tee_shm.c
> >> +++ b/drivers/tee/tee_shm.c
> >> @@ -438,7 +438,8 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> >>                 goto err_free_shm;
> >>         }
> >>
> >> -       shm->pages =3D kzalloc_objs(*shm->pages, num_pages);
> >> +       shm->pages =3D kzalloc_objs(*shm->pages, num_pages,
> >> +                                 GFP_KERNEL | __GFP_NOWARN);
> >>         if (!shm->pages) {
> >>                 ret =3D ERR_PTR(-ENOMEM);
> >>                 goto err_free_shm;
> >>
> >> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> >> --
> >> 2.54.0
> >>
> >
> >Looks good. Sumit, do you agree?
>
> Yeah, feel free to add:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking this up.

Cheers,
Jens
