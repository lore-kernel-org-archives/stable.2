Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C639CD00
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566290; cv=none; b=DM6q9GF/5FNTv3JVV1dz5+rv4CSnJ2AAHby7E8ctgIvTD3B+P8345z3Ctj0qt0hb/DF74y1rMe5wFhE5K+V3LbXl8EaLj/75BZgYg+ckeHz0Z4U1KLzK7L12pm8t5zTD/aiqJfTPfBKy8pBODn3ttCy3CUA6n1vZtlx+c0pZ7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566290; c=relaxed/simple;
	bh=yarXFOpzqWnE+NW5HpWbsJFTGBY6u5WOzXmPUw7r07w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OYKdb5H8bqCPz4ggJTSDqDRUXbSrVZ1w1biPuOoYXEvMIVktdC1+8X5Hzybf3jIRkR6Jdp3slAZwXp2i7Y9Dj5G4UBvPXkuFASnvF5mQOfyiGnZYRlezkxtk3QbW5K2R5cJE0emGxege0RSOHB6FlHS887XnHCVidSdjmAlNK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOK4NB/S; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOK4NB/S"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c96c92c0980so929655a12.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566288; x=1789171088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fd2qPCapWM+8MBnNjVnfMcoloTL66/axX8ypoPSpRK0=;
        b=YOK4NB/S1+IqAqXjnS5bJ/cKOaPYeKZOQirQ5tpLSZ/W+QGcW+GeEmBVNIUjL0RWA6
         8+E7mscIE+7Sz3Bf+MKrCrJbym0wQy6TzVOQ8p+3+7TUmwsor0HwfNv+PwuCG1ChOSjH
         9Iaw2xzIcotTiFa/lUzgg9QNIv28wyCi0R6Dx+tJJxlJIRqNbhevfHMlk7hIYGXyWvAV
         HNJCux6nS9ttaH3InO2jfUfz5hnrJ5kHzEYSrzayTG9Q7vb6WuHqazk8DADTAWXTQHuA
         YXm07N6o9oWgeMa/hmhVvPT4ox0W4+w0jHMpfGJaqRT9DBdell5u1AggZxejU0dwvUyp
         SpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566288; x=1789171088;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fd2qPCapWM+8MBnNjVnfMcoloTL66/axX8ypoPSpRK0=;
        b=cKE3HrQoyAarhV5k1q9RGmTowcH+1KLXF3FtCfopsmFibYx7FbJ3FIAvhkiRkSggKl
         EFnm6ifgy4dXXukCxC7f4CU7sOSpYPE3Jtz/wtra5dTnkO4roHtCP2Q39tFPp+L1cBiw
         LO9dl0F1LwnOgMRcF/Vh2f5W4GA1DoEm2d+nCXGT/9gthegyupjo4CaCii9q/+X/2tJy
         eQc2xDBJVUXGj+j6ceNIw51aAsZwv4UnJFE/7oZX0m1PRf/2xg8tlx8PceSim8F6rd4A
         I0bS9E4do58/hbwpOGeyUadmal0wl/7z3W6omZoPxshFHiXe3aK/sTNFYuGctp/N4XwA
         YZwA==
X-Forwarded-Encrypted: i=1; AKwUvBwAT1Xc9t5pUiL81u3jODCoCYvC984dVXewurE0OZFkA9l474LbOSUl6BQoYdXTOZPqNtqe8Nw=@vger.kernel.org
X-Gm-Message-State: AFuF++lOGbGXcNpypYRucIZi/Psa9CT9Ao5qnYU20IiAKNmqv5NU5eYK
	EqdDLV0OKB3kWTrgg9pWQNQhx1z+95spFOgzvLJBVf25gztLcNNjadd5
X-Gm-Gg: AYBFou2U+VkHWoXdZjdJ8SRm4LBIwWbL9E/r/7YJcc+jC/F8+P+ObJPRC+V0gd4qvxo
	8LHhG/YQvHbAwc2or9FxdMd1BQE0n0T/CT9aCImQB3yN2FWe1QrajINJ9eRp+keOzRNH19ejJni
	nyJRBm5IhXDx+zZjtheeJ1H0TU9f1jUcOV0ip0429ydlnHL7tMdx4hTrljghtUdyCqgnh77+/c4
	TyCk2/KaDwrmAkWZBrgkXVpf6wY0IPrOUZtmI1QYDOnkGEuf3A+aRv9rrUE6K4sINK5HN/yblM/
	PISvawNvMouqnKQie2fRT0BXhMlLZz/D3XJZU9QmMNwBibC0KWQtTAk44F1gP87jzYcdhOUJZIq
	kemSgLhCIxknjUjNoK1nzQRacskTEPD2cAw6f/bkJUArkpbDi8f37cP0m2omG+w2pf9PxC+K0Dj
	WvJXhIsBYSsTSGOCKgnxcG0uGXt71Cgbu1vHMqWy78HakM87elGBilktE9qm3AiE/n0+vepQZz6
	w==
X-Received: by 2002:a05:6a21:828c:b0:3d1:39e9:b267 with SMTP id adf61e73a8af0-3da39b721f7mr14030650637.3.1788566287848;
        Fri, 04 Sep 2026 16:58:07 -0700 (PDT)
Received: from ehlo.thunderbird.net ([76.91.223.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm10577251eec.30.2026.09.04.16.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 16:58:07 -0700 (PDT)
Date: Fri, 04 Sep 2026 16:58:07 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Tristan Madani <tristmd@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
CC: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] HID: hid-oxp: use cancel_delayed_work_sync() in remove
User-Agent: Thunderbird for Android
In-Reply-To: <178855662286.3192124.2102579968112413785@gmail.com>
References: <20260904105800.3923987-1-tristmd@gmail.com> <949B786B-375B-4F2F-B209-C135EC62E1A5@gmail.com> <178855662286.3192124.2102579968112413785@gmail.com>
Message-ID: <F0F0B5FF-2527-4577-8EAB-B09D45566824@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 4, 2026 2:17:02 PM PDT, Tristan Madani <tristmd@gmail=2Ecom> w=
rote:
>Hi Derek,
>
>Thanks for the review=2E
>
>One thing the Sashiko bot flagged, and I think it's valid: if
>oxp_hid_probe() returns early on an unknown usage page (the
>default: return 0 path), the delayed work items are never
>initialized via INIT_DELAYED_WORK()=2E  In that case,
>cancel_delayed_work_sync() in remove() would call __flush_work()
>on a zero-filled work struct, which hits WARN_ON(!work->func)=2E
>
>The non-sync cancel_delayed_work() didn't trigger this because it
>never calls __flush_work()=2E
>
>Do you think this path is actually reachable in practice, or are
>the usage page IDs exhaustive for all matched devices?  If it can
>happen, I can send a v2 that guards the cancels=2E
>
If the usage page rejects init then I think we can safely assume that it w=
ill be an effective gate=2E

There's a series in the works ATM that will make drvdata unique per hid de=
v after the usage page checka, so we could also wait for that and if it's n=
ot fixed by that series then gate on drvdata not being NULL=2E

Cheers,
Derek

>Thanks,
>Tristan

