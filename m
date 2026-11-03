Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.198
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793733281;
	b=c0Rv1hza4hXcg/Hi9ZNGgkq5Ng9dk9W/1quIcJljLrT4idmkC4qRhGQORsxUOrm3YrvG
	 9r7xPkzlNl6T51HZgv2cZL1a6a5yfJ6qdHJqBBmb0lI3Nd3Wuh7z2NK9g+nbwiHSiTpJ0
	 /+R705X0Xv1y7ErxvSywCu1poYDDZDKW7o/3YaVvmOZYU+wnST7yWuWzR+OaVymBpqdWO
	 dw5kZqWrDxNbpH/Ox1Z+mZpAczos6yJoRwNar7diQRbSuERvHz13Pboe+mSkg0r01+KKB
	 Keosh2/JDV0KiNFt5NQsRk/s0gOwM4T+gYDdrfZmC9QghtePO5tijp5gy8PcvtPC1ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Zc8kDAvAGcUtSSTv1tiJtX+vTgkLMgafaiJRnJ1QVh4=;
	b=QsPx33A+kYYM4GBk95q88L8m+2gBJ00kdDwWa/TVn3bdLooUlqfp1eXnWvTZzVICl1lP
	 NvGz1UIRDdWRUJrJ0kWW9rBlIlePvemGKoDdigNw4WY5L7zEXThT+qG9KpAWKEmJSgV/p
	 gN1G5XwynfL0NJXcUq1QMyCk00WST+5J33wCFftXPSIA9igZrYv+JydQPk/eGP0Nj9M9v
	 LRWO38XLPsnow4/14QH3Ke4JK49DztcGFXow94uLN3PKh0yhI58hhgjBMo4kxmDGO4NL8
	 mieqb0SgvZfuG83U/Q+pBG/+0Cywu2ciSvHQyz6yNwsg2VOZT282aohnrhuNGYXx2uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SiydzYN6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.198
Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EFC606A32D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11EFC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SiydzYN6
Received: by mail-oi2-f6.google.com with SMTP id 5614622812f47-545a4fb8d5dso2355910b6e.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:14:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793733280; cv=none;
        d=google.com; s=arc-20260327;
        b=PlNGOZfS9htBgNMDbsOllldP0YEXLJBw50xUI50xmmhonkEPpgqqUVzwTqupcgTChL
         Aoa+QCFcWQY8MrTDzzZf6EKZaZHiW1cEWNBQ4GFYgmnqvDZPTTWZBe3NC0ITI3+5LokO
         m9TK2oNzbCaZZz20t+qYQzafeKE/kIKpc5rGgKx2pKIcCyDfxxg2J0B80uCNF5L15CrH
         U63uLrfY+9ejgPQAyNeJv06MVP9d0ErWC+h/ZVerqZZYPKDF5QU7lPctLB5aFvt/xfdE
         DdZTWkiAP/SFw6I0HXa+ysYJb6F/tfS7k9HdVkZdCi2eKzKQDTnI5afjlon2XwzAswr4
         6b7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Zc8kDAvAGcUtSSTv1tiJtX+vTgkLMgafaiJRnJ1QVh4=;
        fh=GV+DGAW5hGAoyT32VMJz65N0lbRiKKynZIM5CYE47lQ=;
        b=Soek9X1uREtSBSFNd/ahgBVy07XIQReUS2Spg7asnjLUhklVCR7hofNfJu2oU+DOvZ
         zDgx11lzK5eupjk8bsM1Y6ByVxiiEmRwm82GQoJVf2yQ11wiJDmQ8X01w65oTlNg8s/E
         TABA7kRS74MXYLIC4TZRZ09pAFBsepTn/W1qC4rTyYfZnHK/COX1uytqzGfBnpsZq1bC
         8ZFLynUf38nfqkwhSW3rEhIrh1DfPVt3hT25UWx6TTgUoRynEsanF+awpAASxCQDQN9G
         /KZND8ou1XfRIWv3WwXNKdZZ7xRrw1eR2N4+7xd5I0caaqdsm+JG6p+mltalIzpBh2J+
         k8uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793733280; x=1794338080; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zc8kDAvAGcUtSSTv1tiJtX+vTgkLMgafaiJRnJ1QVh4=;
        b=SiydzYN6TtHDWtb4/2fslTv9U9W3eohofdHMi+vgsK8sqM8Xf92PZmLtV6C0q3vEab
         9k40X2VfLvtL5WrgBbwLyiRNacLzRtD+vyj0fo960l9NcebV9zSl43c0Nv7ox2IHkEVH
         U/cylVbXKnS+yxgEgxEAirzs1f4+vb/xrrIM6zzAXeMSgWdiOY+3L5eSBQgHntjdJrQq
         QKAS0GD6ku+vmnPfhqpq54KbPUjrxFp+ih3Oz3L7N9e5jcONjOTIhEvxN/fWpSmdQBq3
         viKiA3Qvd8AVuN+qqcs244S67XX3QcHIHZPFBnB41CGKLr9IcvDwmoUsAMqqnor+J32e
         6W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793733280; x=1794338080;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zc8kDAvAGcUtSSTv1tiJtX+vTgkLMgafaiJRnJ1QVh4=;
        b=uB5dvMa6s1TGrnFVj87uYKxoIPz2v3rVBOtP4g+hY6xSxVlUXDhmsWx2KFyQXuzy5d
         EqmPMhpfCs/1tihM0E48GPJz8Q0nhhZCwwUG5SzA7H14+WCFkMJlIKnUTbB5Ks63VmrO
         eb2s5opzjUngXM5iHJSEkZsykF1vTIz49TqcIMw3zhUPy+0nbpoAQYySe0rhG9i8Bjge
         UpWZ9P6Gy7V0+FX7ptVdwNQjjdWqr3k/sRtlgfBGYs+i5vqBkhQYHSwjRGumvNt7lw6F
         GOUmfffMMw4ASCYrzFgzM4Luwq/c7QTvbBNTMfIiOAISfYeumMd9rDmiCl+m0FTpGhud
         S9ug==
X-Forwarded-Encrypted: i=1; AKwUvBx4taGUXJt5nKXBwywCpb4+hQTbzYT3Y8hmm2ANaMWLO9UjaUaHZwvky7wjIIY7AecKWOYoeLQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9e7UgA/BCwuY4PGBVEzHGYyTTi8rSxiTSa/mIofTmxud7TpzSk
	bae7s7AksgQf6EMhHa7bJDSK1lpAAVkjtVz6Zc43xO/n5og2l++DWsmA/aVVoQFbIYgoXDEZL7J
	/7wDs7pg/CFekiMrH365ppsYGGnDzV+k=
X-Gm-Gg: AYBFou28xWMIuegRv/2PEAqyFJo08MKnvEDWSJ97TywDbD0D0GiGVqsNXAHWBLjfyKu
	ysouA699p/E1U4AhjByRfU2t26/xaevAuihsEUj++MauMBot5iXLZ6ajw1GtV5NkmKNVNsSQ5vh
	aBd1JQnDavDRzYh3gEWGM+8vgC8HZjZGhOwUaQZg32mHpNeIAMRVAdaEV6+TVJ7T8QI2IXUglKH
	YW6RzTNlM2x/uhrwoK6/i0V6uZ1y9p8onEYxpzc0WlJVRcK+duCgzU6Yl9xQKyb5rrtI7jJRYEm
	xtx5Z4qFJtVdUfgssdgfn80ygYBstaTIVHzqhYy/wwQUOP7eGTVWnzXoQAEmXHJe3Ixk8bZYlxP
	xGqzhMfXbOlQrs6p1S4URPAZyiYg7RKfQCst4zyivslYsFHXmzP8Yf7/f3vm3dU9705f0
X-Received: by 2002:a05:6808:3203:b0:55c:925:9d5c with SMTP id
 5614622812f47-5640df0b09amr9395153b6e.55.1793733279946; Tue, 03 Nov 2026
 11:14:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025164619.89992-1-dennylin0707@gmail.com>
 <at9xXRhD2xZhszEj@thinkstation> <xmp7ni65vbinfj4j2baisrhp6xzro3asbepuq7xp3mvx6maptn@r4dnoj63uw4t>
 <at-XtWBQg3jv3H8Z@thinkstation> <CAGEkeHfq1xZf_jMw9a9cz3iunj6O3UZ4-=iW-65aN2Ss0oT3Uw@mail.gmail.com>
 <rfvf7awrww55bg3hwq4edbz2ioorodlrb3wcmf45wcrof22cda@yduswvswhz2c>
In-Reply-To: <rfvf7awrww55bg3hwq4edbz2ioorodlrb3wcmf45wcrof22cda@yduswvswhz2c>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 3 Nov 2026 11:14:29 -0800
X-Gm-Features: AclHuK_K2i58ZgKI0ZncbiD-FXwtR_64S7t8qdGgihK-Yj_K5O78XEMeQeLdpHo
Message-ID: <CAGEkeHdALf_Pb8m+qUE5ZSqTWNn69rXyy33Sz1-PKJSmGxvYCQ@mail.gmail.com>
Subject: Re: [PATCH] shmem: do not extend i_size when no data was copied
To: Jan Kara <jack@suse.cz>
Cc: Kiryl Shutsemau <kas@kernel.org>, willy@infradead.org, hughd@google.com, 
	baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The trouble is that practically any filesystem is going to have these
> issues with 0-length writes starting beyond i_size. So if we can fix it in
> generic code, it would be certainly easier in the grand scheme of things.

Understood. I'll try Kiryl's approach in generic_perform_write() and test
it across the affected filesystems before sending a patch.

Thanks,
Hungyu
