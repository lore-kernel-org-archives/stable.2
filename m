Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706967;
	b=3jGChwP4dHyIXuAMW3z3EYUeFGOP1SmRy5sXGWe0DvrrCHUBdTJ0Jk/WwaHuqdfAa3z+
	 JiXDn1a35AI/HDsgBgHfT99U6UVyDWc/nisscbeZVDZ2RLJ1Q0eju8dXAa6yofHHgQhE8
	 CcX6LEMC3aT8ah0LWTyOPQdy1SlGZp8tc/Ch3H0QH485G50rsRuyur85InMFusi7LkaI6
	 ArcWJgLfVEKlIXseB/sruuBQ5D3305LWu5rqjUelsHK02PVybvcyK6H8n5zjeRk0niYBG
	 XX6FEkHipH0ZyMXNoE07pyVqPd9QDj53cLxYtBLjZY3xWKyyXWZoqygzswXqxJ/1f9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=ONK88Mc3FVMhpnTXlcgn9JF9XGNsz0fFBW8JVFGM8tQ=;
	b=vdSGOpqZV17ih5sg0i2yw9knEWkxBRfoRmGPnZQjuRmGMLni1Y9AQja1RuYklyFG286M
	 cp93kcCBTIr27FOZJIKLQ3NufvVM/iIRv+PWpd71PVXmQ0HBuInS9hWlgTIfqIsI3nK6d
	 MN+liT8J/xq1w3Vd/7o6bFx0PgtlWGjbVd3w0Wy8XeR5soFv+I7n+e92VWKl478Xw8F4c
	 6NveXOTCL7sZTN03KpDTHIb53la6mz7gWXjZ7BYy65Gh+Pw76XvW82XAdkzKzKysFTU+G
	 +Wtir5DT8MlaJ8K5tD4zGvb5g/uBFjpoaPf43awfdMszRpo6HjYctSotEH9qjF03pUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDoxvMNL;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9EB606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C9EB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDoxvMNL
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2e85fb35300so7324995ad.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793706967; x=1794311767; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ONK88Mc3FVMhpnTXlcgn9JF9XGNsz0fFBW8JVFGM8tQ=;
        b=lDoxvMNLfTfPxFe8IHFNe3DHmHNgCatUpfJIOzy8t2XSpCxlyg/qolVA52u19Hwb5c
         L5DTcJHoV1Ebi0ieNd3KR++C3RrDJzfdvd3CFrxvCjDfE0zKWAqCDriBn6EHb+l7jgdd
         c0VySSEGndg8Y16paAHpux4jdQeODtD+GfPsGddQNFbFIpag8uHJwEzcPbyHOxuVwPGu
         wyiI0bbiSztW/GLIe6eoPKK2PTucvPlGTvGAOuWmVLPADRyAESI/DgKLeR9S8zRm1Mdt
         sNu36q+EMN2xKf1+AjI+uH1YUzoFoX4sYPw1wB2U7USZedNwBNa2nM3/+4SmfP2DtP7I
         UzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706967; x=1794311767;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ONK88Mc3FVMhpnTXlcgn9JF9XGNsz0fFBW8JVFGM8tQ=;
        b=2CbwUXX2amwCoFJYAOFcwqg/A2fAFE9FpfgyLmEeVzEvHxGzCCi0bJxB4OqGNv/4kg
         cLoN1r/mJSZUvLV4io6VoLUh28Ajl0dBEjNt2hmCBoMZFBwZ0VORnlcrkbkhLIrZuzg0
         6tcGBX8k9jOmUV2g/bRbEUq0hrzDrPf3ysCfxWOPtNSZaSAUfXaB9D/lZCfUQc+LxHSI
         B7nX7sMc0NSriEfsH2Q7MCDN33WxPVj9NoO0kfWJVIkXb8nTefOUut3u9PgRYFXeqk04
         GH3A2CH0BQDpd7mrlFblCPQtTDLkNecohFXQtHdQWiH4G30qurZQOKUaUKRtiFZiT5FI
         yipQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAlXu4+DfXcvFacNE0feyAohZyNETsgafhxJJ0+FZi4EyRV/7KjJ4bE5HMEx/2PqzmBS3CZZg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OZ65lC30TpRPSrU3XXsWv3zQlUoFQG1S9w/BqlmMKnuiOd02O
	W02BElyH2plNRemGven7GmBQDklaOUaerDQLtXITnHohVloY9MtJw2wRoTCpyjILV6I=
X-Gm-Gg: AYBFou0tUpN0ObmNyeShn0c9AZpqfC0KweGQi1yVOxKGv9IhGOH3hmAiPG44lSs2Bur
	dsnxlHei1vZ/L2KNHvBwTozLUWxxkNb7Bno8O47Pyx7tcomRZMLzjM6eECBkye0Z4V9iRuW0Bps
	CQDuY0ExwmoTKUVk1vTimV4MskYW6nPniXuXzFQtPhHGYjRC58MeUiz4PTY6JdV+kI0lhhD5XZI
	S4iCE3RWDJyYc728swusKDZEty63Voyrb0vPJUwldJwhXSweOV8lsH2aGMy3xwzabw3MtrXX5py
	w2+Ctqnh6CF3lHDzJfsERgvx7A0maU0AV/SoU8G9AgWzXPvLGuiFSJD8VC1w74NMEQqwMj+jwms
	TqbmeJ3DK+Qfe9+VOAb6qiCyrMlSHAVgKdES9CxAmsGY690N1lOEpj8qOQj0DvNX5umCVXt+aQm
	bMgsXg80MyzQ+Oz82SZsHoyAd5zM7VLMSlfVmYNtqy1J8XS5FNbCXuwziA7jbMx6Kw/s8qv58c7
	g0aFidce089ivefcrOqATQuqxaSxtZODviEYO0dYqTpYXDHUE3pkbHyLSa3B9rbrc5lTamYK3e4
	j/HikgecOPl/LzJamcuHxy7pIzn8VnNf6pX1M4jXpqv2N+y5RlhA7ht7CeKyP0NyiAjJyeoAydG
	LlJBxNMn5Mha73WJ/Z9iNsWl8ZRs=
X-Received: by 2002:a17:90b:1b0d:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3ae89776936mr6987759a91.28.1793706966861;
        Tue, 03 Nov 2026 03:56:06 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aebc89475asm5134252a91.0.2026.11.03.03.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:56:06 -0800 (PST)
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
Subject: Re: [PATCH] mm/damon/core: reject empty access pattern intervals
 on scheme commit
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 03 Nov 2026 22:44:03 +1100
Message-Id: <179370624368.195197.14262032219867976650.b4-reply@b4>
To: "Xiaolei Wang (Kaihong)" <xiaoleiwangxiaolei@gmail.com>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, david@kernel.org, 
 error27@gmail.com, "Liam R. Howlett" <liam@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
 sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, sj@kernel.org, 
 stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>
In-Reply-To: <20261103105418.362459-1-xiaoleiwangxiaolei@gmail.com>
References: <20261103105418.362459-1-xiaoleiwangxiaolei@gmail.com>
X-Mailer: b4 0.16.0

Hi Xiaolei,

On Tue, 03 Nov 2026 18:54:18 +0800 Xiaolei Wang (Kaihong) wrote:

> At runtime __damos_valid_target() evaluates "min <= x <= max" for each
> of the three pattern dimensions.  A reversed interval is an empty set,
> so every region fails the check and the scheme silently never matches
> anything: nr_tried stays zero forever while the kdamond keeps running
> normally.

My understanding is that DAMON just does what the user asked for here,
so this looks more like an input validation improvement than a bug fix.
Since previously accepted input would now fail with -EINVAL, maybe drop
the Fixes: and Cc: stable tags, and mention the behavior change in the
changelog?

> The same holds for the watermarks thresholds, which must be monotonic
> (low <= mid <= high).

Not for all cases, I think.  With mid > high (and low <= high), the
scheme still works; mid just has no effect.  The subject would also
need to mention watermarks.

> +	if (p->min_sz_region > p->max_sz_region ||
> +	    p->min_nr_accesses > p->max_nr_accesses ||
> +	    p->min_age_region > p->max_age_region)
> +		return -EINVAL;

As Sashiko pointed out, this would break the DAMON sysfs.py selftest,
which uses size=[4096, 2**10].  Maybe update it together, and also add
a kunit case and a note in the DAMON usage document?

Thanks,
Aveline Noir
