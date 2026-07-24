Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5D32B9A1
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907836; cv=pass; b=EexO+REq0zoc/PrUaiLbJaA78NTdt9yGIEduB8uLvouWd2XbtWljvnbXaHUp1G7AQpAwEU+HGJ6gIOsu6VxLsh9UEtrcx6oOd0exjiUJaBYGqxZFi2NfAgDxb0lu5j4hS0dKssM/AsIfTZC8kIQ5iVao/qKIfDq9FGTQBlVfVc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907836; c=relaxed/simple;
	bh=ILofpUWGWH9zp6AGMmvbmtrtheP7UpO/eX+BW6pBBWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZ0rBf2m/D2lDSycqiaYAhFZSS1Lg00k2DBOWwlJfpjEcSTRMOVHq1HpGWAMz9sazlCn0bBWrksmDgqdTUEr0t0r8vbcKswdXCDrds86LgN0Aj14dhlRwuISn0vOkpSU0r644DMQuOba0aLhqa99EX0Vdvd5Fh2t3UfLu8QscUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fFeaWtiF; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fFeaWtiF"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9f4ab2a6fso35785a34.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784907833; cv=none;
        d=google.com; s=arc-20260327;
        b=mdbcwsBFv0f1Zfj9Hw4wU/twxYuhK/ZwdmPWhzcphIgw5WF/2DJhEsaSdu6fN3akIR
         3B8zBylayAgVG1XshJo7/AfmQaFm/KS0NEfuSZ0PKSeB1Ko8+I7NTqE3yaAF7fYJVU5I
         WQ/XbZBsv2ZhK/2R4+/ktQTYzY2i4SdJdfgbAMHNlcvHNrGQiPj23iSxXmrd8FG1jetG
         1Fi+AE+aU5aAd/jYzR+sB6nPjhs4+ov/YpFLOVaJ7f27z1588yRiTynxotVnGttGwz5L
         kUoQOFNsA4O6NRGF/+Jo5UfEhBLjqwVwa1Ybgx7ejIkRJrJgHC0kQmiMXwAnAm2jNvav
         rPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lvfkPaw63mygCj4Ez7HrV9WaH81ot3VV5r5WvjvtNbY=;
        fh=pIeA9e738fLZlPYBgDbpsW9cBaN8EmG8ggq8Cout84s=;
        b=qbrntbzHQ/g5dvKgmFQuq11x6Wn0IqGdre9uJ02XiT5gJ73xSNku95SpfxnGbZ434+
         v85WNQMBfGSI+Tm9lQZiMajmxVkNJd48/D8g526NWIHlDdHtZaBh9SgGeyeuJG9kDl/p
         HcIdRLZNcR3bXOJlN4pOucLO5sPz+16JHaE2b5JQOAh1urtdFpSZy0UdHK0sA43nv1TR
         trXEhpC52rwbQGrxYVR0TuzdudFuaPmWWygK+6vdWGKMQ6QQ+o02j9EJ8ieC0Z8jCsca
         yeoY8eHIncSJ+wH4hmA0sh2JgdzQyMm2RlgbDWViEwLb3Mkigl17Iy/koxRqW91dh/Vs
         sabA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1784907833; x=1785512633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lvfkPaw63mygCj4Ez7HrV9WaH81ot3VV5r5WvjvtNbY=;
        b=fFeaWtiFUf+jNiky+HPe+Nc19K4llYdf9nya5WHaGrigiwx8Rkc/9r1vkuxGSNIkeE
         MLMIvwOhMYf7R8hoGifZdoGfnKgnw4Me0GdwxO9/PfeBwSrfYy4mJg4lVsQ9MNaqpIjM
         7o8AJrBIDiGzxyC8xaWxLsbCfwoP67TN1Vo+Twv0HIKGEThqPcy1ZcJXzF7LuUJb+WBA
         BnuJQboKRbiEAirOm/C9LKohX4Fca+9zwl/xUGcl0Z1T39IFNRbH3hGedCnmM9LrILnr
         zHgM94B/DbhEw+cVmgbpOCVN1+A+bQvy9Pi+8PPuCH8f7w/a6EBdtWog/7ZE/pGZi3Hm
         iDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907833; x=1785512633;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lvfkPaw63mygCj4Ez7HrV9WaH81ot3VV5r5WvjvtNbY=;
        b=iqdNhrF3xH/RAuTczLvVoiouyPeAzEhL4/Ne2aGsrXHWjV9BSjtYCGwx7lKFFxs3YH
         9UqAQ4U7vyz+XdQg5ubBDUzlbnlskxRXrBHQmlH45FcofCXO2BW7mhm2ybCaKXWLMzjD
         KqKerCHFFjguyoad+lDUwTVNmULP13hKp0B8hl4VkVhV9KySEW+OtJTrGQyRoxaF3sF2
         wNngB2IRTrArkv3ZDUHR2NHtsZxKxUXgHuTQvDu7EYrBssBYe7N2sGeAXxidtZa3XE+V
         jsKi7sP2cLxWA/wst0I0aAhM8b++YTuOWWxs/DgWo9e74ix+0M+j+cBl7DEAduFVjhKV
         +ZgQ==
X-Forwarded-Encrypted: i=1; AHgh+RrK+zyUIIspCRYFDOb6HWYvV20M6h6hUUD9XFsuFdZ0nHwfAOxh/7l7+ppuZW4Rhvx3kWF1ytI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx604jaAceQEEOgKMtvJr6DNs8FiPDyyvjwMBTUTlWojdXx5kg+
	RjBQ1bLOlVnYR5MzioU1ZqrHox2mJrEBWROyz41vbDtSz69CiAtz8nrR4WSUcTWu4zpTHCRHmV7
	Nc1ydQWgo7DczWOBmbkdKM7qxNfK/JcMuOeDwqMg8bSF2hA+0OKwxjXd7EQ==
X-Gm-Gg: AR+sD12AwBzOh3VIYHhlL6BNZQ2vW+d6GXqc0SChTmzBuWemhainueXrY/jiESIknMA
	lgFhipyIwDMB+wxXlpZIrqHUTSsd2lTIJp17lsaWoI/LLzfXXw/r2mqKqw0uCR+AGxdWSzW1X1F
	7qT8nFkJe3eu4qVzCu0Wk6EOPNmm9hIcbp1gwHO57vF/w+eBjTp9G+QsAoUUfRgvjLjpCCDU/+J
	mOBcAXdRYZOH1nsaED0Ok5fZZlCy46v1IR4OTufvwnAfPxkhr9ddbzzRCHA1n8=
X-Received: by 2002:a05:6830:61c9:b0:7e9:cdc6:b930 with SMTP id
 46e09a7af769-7ee57ae92afmr2130467a34.6.1784907833352; Fri, 24 Jul 2026
 08:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720032338.461681-1-yangxiuwei@kylinos.cn>
 <20260720032338.461681-2-yangxiuwei@kylinos.cn> <CADUfDZpAW261MhFJg434=4nZFMD7mV=LL7F-ZiAWPa7dYvGpcQ@mail.gmail.com>
 <20260724004907.2742329-1-yangxiuwei@kylinos.cn> <CADUfDZpsTH7zU4gyVE11R9GxdadjbcrcGVX+btoEjRYS-tBiGQ@mail.gmail.com>
 <20260724020240.2938587-1-yangxiuwei@kylinos.cn>
In-Reply-To: <20260724020240.2938587-1-yangxiuwei@kylinos.cn>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 24 Jul 2026 08:43:42 -0700
X-Gm-Features: AUfX_mxV-8Cou1n7v3Ks8R-DjIB_eyYje8GjN7815YyL2Gqfxab6vzNDmm4_9HM
Message-ID: <CADUfDZp=pCYGY0TCnMxXPG3LR3Kwk3DB-Hq+EvHZshruX3pv5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: bsg: fix TOCTOU in io_uring passthrough command setup
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, 
	rc@rexion.ai, axboe@kernel.dk, fujita.tomonori@lab.ntt.co.jp, 
	bvanassche@acm.org, linux-scsi@vger.kernel.org, io-uring@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 7:03=E2=80=AFPM Yang Xiuwei <yangxiuwei@kylinos.cn>=
 wrote:
>
> Hi Caleb,
>
> On Thu, Jul 23, 2026 at 06:10:27PM -0700, Caleb Sander Mateos wrote:
> > On Thu, Jul 23, 2026 at 5:50=E2=80=AFPM Yang Xiuwei <yangxiuwei@kylinos=
.cn> wrote:
> > >
> > > max_response_len is similar here: we clamp with
> > > min(..., SCSI_SENSE_BUFFERSIZE), so it cannot overflow the sense
> > > buffer. Same idea for response.
> >
> > I don't think that's true. Without READ_ONCE(), the compiler can
> > assume no other thread will concurrently write cmd->max_response_len
> > (else it would be UB). So it's allowed to load it multiple times:
> > cmd->max_response_len ? min(cmd->max_response_len, SCSI_SENSE_BUFFERSIZ=
E)
> >                       : SCSI_SENSE_BUFFERSIZE
> > becomes
> > cmd->max_response_len ? (cmd->max_response_len < SCSI_SENSE_BUFFERSIZE =
?
> >                          cmd->max_response_len : SCSI_SENSE_BUFFERSIZE)
> >                       : SCSI_SENSE_BUFFERSIZE
> > And if cmd->max_response_len changes between the second and third
> > loads, this could definitely evaluate to a value greater than
> > SCSI_SENSE_BUFFERSIZE.
>
> IIUC Kernel min() is __careful_cmp() -> __careful_cmp_once(), which does:
>
>   auto ux =3D (x); auto uy =3D (y);
>   (ux < uy) ? ux : uy;
>
> so cmd->max_response_len is only loaded once inside min(). The outer
> ?: may load it again for the condition, but the value coming out of
> min() should still be <=3D SCSI_SENSE_BUFFERSIZE. Did I get that right?

Without READ_ONCE(), there is no requirement that
cmd->max_response_len only be loaded once. The compiler is allowed to
assume the value won't be modified concurrently by another thread
(that would be a data race, undefined behavior). So it's free to
combine or separate the loads. If you want to ensure that the value
read from cmd->max_response_len is consistent, READ_ONCE() is
required.

Best,
Caleb
