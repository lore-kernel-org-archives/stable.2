Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315B3DDDDE
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391000; cv=none; b=iLqNPxC4Or28AJ8rX6aRb2vqVs7VxISWAJtIpA4DZlwtgrDN6s62gT5nevesRVZ7qVfoSfcchhJjr/uAoEjO6sHKF11q6DVyfxSpZOrIx96l1EwBGl1Yv/8/meQhDQuUjQuMvpvL51nbqiJdivKvRTO8GdCGIqx7DBFxGFBRIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391000; c=relaxed/simple;
	bh=ikUic+N3QzLsfNnI3YIATm18NVXpKCqxJzugmGA5UwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG1AGuEh1mTDB7wAuFuTIw5ulFOqqSYfBLR88CtOkCEDlKe9TDE/tU7QH/7mOh9V6igO44AQGjBeTB4LB4VnyHU2s3ay+dEtAgtvjSAkpZW1ahhNUxeIqQV5ektrwMfOavSVDM/qUObpsFKLYi9aE2EbZ3sS2QkeGulUOMbqeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQuQNgSV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQuQNgSV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso8381055ad.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 23:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792390998; x=1792995798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EoiDhGYBQsA+EuE6OZ11L0CNeac6JOocBhHY+zeRqN0=;
        b=MQuQNgSVzXqCGo/aDNOusoian+mrXF/Ayy+/hHNJuupBQDul3QR/SWDRZYGBKRqn+l
         Rk2qeV/gK4GLykbsM6nd2qezw3l3xXqBXwcQE4hwUyBFJ6MbykVdo48HuqtmOiNpoldp
         ERtikjs8s5R+PyXcg22WkP2ldz2orb3l8FpEdbprnq6AjBItoACrEDZuIHL/TWABTJfl
         xeYJhT4CqDSjyn4qhHXWYojS6QemoX/NCn6XrbPKILwcGipIvRfsLbp+iSWld8PsCbGj
         GeSUw1WxQCp1k8xhnlE8L8oPVDKwtHH0KmcpdDZBGWpOfUlsckXskno6J5ie5afQ5J5i
         AWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792390998; x=1792995798;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EoiDhGYBQsA+EuE6OZ11L0CNeac6JOocBhHY+zeRqN0=;
        b=v38ccvDr0iAnkDyE19JLiYl1bhOMsgv2x4AOxSoWJfnQx318H8edB5OmOGX6Wk3aL1
         VkSnqvHX4hcNHxqDorlPtuZui+KkpK6NJJOolZDpTBQtKsA8OegQ5kqUBEjbUKvcia0V
         URkiJdQ58KnudpW+1fsrZ6ngqNjuUBmwsZIPXCWp1r8gQ7Q46r2MyPLGoYsR7R0XcYAn
         H7Ox8+FyyXHi5JszzMfgQdXOU9H24HvNvHM+DtW/JIf60V0OQvx741dQS6LBXPv9DIvY
         YUs0WiRdAMXWhHVpVu2Wjh13SXE/A9hdKOyoUg+EIquhSMcVOEKlZXBLrZILDkpiB/fS
         6qFA==
X-Forwarded-Encrypted: i=1; AKwUvBwQ+phS36jx/Bjh9qquamx6vRVb+pr+KgKsGAhCQ+/BO8VsxRWUtokpk/ilR8ZZ7cDBcQ7oeeA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWamxaLAELrypoehxWKZvZujxganZHBxKFog2KBHG8h05k6OVQ
	DwnWXfDyk7/vfapC+UwH9btabU1fDYohBI7lYzbG/9N0fYqvyXWiwzsb
X-Gm-Gg: AYBFou1uLfaWhSBifnPRRDrWkrsNmnm5augy8TaHboBv7YGtfK6z8Sru0gpNmsQ7sKK
	jOpwM7s+RDVRQNF2h3M98ywGuATqL+Pm23UHp7bIBlefuoXoIu/6OKWiFnN0Ysi1BekDgEPS5Fe
	3s/5DeVnldiDsnYLoh7os9YzDA7wEN7a1Q5ooWHl356+IujRv5XxeZ7EYxJgEpuysbOUDaRFZua
	vhAmzYJ0NnjZnMV3NQkloxWBj16n1YkG84v5RQGhM8uayhFxGn6+bs06NyRnBobQ9IOLDOyipIc
	y3PeksQpmrnulcrqaQVh/fgJKTidpkUHntyBgsH/yQBJvvZV3xAn3bwCyICo0aitgJjOHXDCuOb
	bELRVAP46dU3SEFOw98i1wI5Fthss/SwMgR6vzdxJY+/Ot8Ki8KiTnUGEafSnRAvGW0gbYBbm9V
	eD+Gwd1Xh+VURgtCb40N7jQcjMH7Vh+tJPXYciBE6dI0s9Uh9CcIfewuU/9PrE
X-Received: by 2002:a17:902:ea10:b0:2e9:4175:3070 with SMTP id d9443c01a7336-2e9a683449dmr62525305ad.2.1792390998231;
        Sun, 18 Oct 2026 23:23:18 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea0cda9d8fsm570065ad.14.2026.10.18.23.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:23:17 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:23:12 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, ntfs@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 0/4] ntfs: serialize attribute-list access
Message-ID: <atW3UFR2lPfqLSvP@hyunchul-PC02>
References: <20260812-topic-attr-list-lock-v6-v7-0-2f35e0a38bfb@gmail.com>
 <CAFRLqsX+4mzD5t1-1OgWg5K3nQPAY_T24uJHpH853mChUpOkYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFRLqsX+4mzD5t1-1OgWg5K3nQPAY_T24uJHpH853mChUpOkYw@mail.gmail.com>

Hi Cen,

> 
> Just checking if there is any update on the v7 series, or if the issue has
> been resolved otherwise.

I am prepairing a v8 version of this series. I will share the patch
as it is ready.

> 
> Thanks again.
> 
> Best regards,
> Cen Zhang

-- 
Thanks,
Hyunchul
