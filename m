Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647443;
	b=0Iy7doFUsUQS7+ybRzWSKU4hfWpHCKrOd5EZqUHUTLoBU/c98Zey2skwQF5MKBfQJn5K
	 7P2iFKpI+06GsfLfWbkaLMKaeo/xGC8mx+Zm8TfRfPPRTfWv1LwmBSsdwViONqnzrFfKC
	 9IaZpMzPFfxm/zJoGunKX3YGf/yKPBuPxcVsn11bE8OEC6PED7LobTFMm5AfCils4iErW
	 rsgB9eJHv/bC2HMVt4/7eMsf7EoHaMPkpy5sHJZN3KM5297v8B8g1Xm7mKAOK3rAxKPrN
	 p14lRrj3n8Fl8IFzAD4RenbpJZ4mEB8ub0iuyX7J5X3Tcv+Dj8kPilRyw4U3MqGxYPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0OVfCBvpQu7+LPEH8zPzzFoXUbPUS8d7sUdmZNjwHnQ=;
	b=z9TvqwH8OMSZ3Exn4FLX8mBiwPpDwROspmkOZFkOG8nWF1Np5uxRcbsOu08O6bpSfXh+
	 MPPvxlm/lE23wdTbC7eH7Xuox8bvJ+O2QyxIj8m++CwVDgqmZNk1F+5jL8ennzsWWSvNt
	 zAtcRr7QOVvm2o2yN/grWrS+4iBU8sSiPLBzmOACpDxj0QG8vxp2mpvBEbVMychYWyQUm
	 IZ5Ymq1v/GXCrwl6q3j5aENCLPXYomNpiw8HVNFI5O29oXkiAtj6lvZH9vzsx6s9wfOmG
	 /M2e3PDVM3oUcNFOuVbRNk8Rda20RiU557MMdXOdsx9OL+lJqKjTRTIIBnXOxeRLW7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="nHe3H/56";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D9606A33B
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 242D9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nHe3H/56
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2db1b9bf2so2183543137.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:57:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795647442; cv=none;
        d=google.com; s=arc-20260327;
        b=jB/hJyd097bp0MkQCjPafDwLpfCgH1u+ioZhmPeNizUoHIHxWf7l7EaZNuyBTbu1lm
         qEAX/0kWkStZzBT0a2EvKxcazPSk7/yT3YgnAqKQydO/wtusvy7Chlfnw32isi6A0dHu
         /HNBrDdJQbZqc3rIK0Gbicl23kkF9jN++SvLZGmtVFqbF32NCO+fwj4FDik4Oc9Lbehz
         WX//xAQBGNbjbvNPxkegZ/H834jrWjXsMyyzpSPX5ND1RT7mw1oYm+iD1Qt4OkpTXxdK
         2XjnIHBEEtD+QV4IALnqk21UO0aJXWDJUpyp44hTvHUsgMEgSuBG8OQHnv9KUWRoXbx3
         mt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0OVfCBvpQu7+LPEH8zPzzFoXUbPUS8d7sUdmZNjwHnQ=;
        fh=aF8MpP0pK75XNcjEl6/AqEzLH60sDSeCwUUpWfwISLM=;
        b=Z8uuBmgcvU4QoUeA0slLzS/VkAFj+9EGQ6S5jr0WF/hryHMkQhFVfcTx5HT4QRmy3M
         rOaZRDImjzGnlBGMqgm5Gj8bu3mxjo5FIwUOhZlKbeysVsCwuhUc/RNcn5CdVFYHnH2E
         zHsvSECHk5SGul9CKq1yiZrqSH5NZDVsPpZGoQoz6GqHKdcj8uYE6RYS3HV2UbBYMdMD
         PZElBYFyrF0EXYJPR3C3UOIS4w3a7ZFIn1g00p+C3dS6wSkvE2WZGihBWOI4/ZmVdXlp
         yWNAlcqoNBTxwVNd0J1t9MngOlbuyk+JpkST5+w9rjJ2OqK67LApJ29OuLbdjhHAMVTi
         iS3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795647442; x=1796252242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0OVfCBvpQu7+LPEH8zPzzFoXUbPUS8d7sUdmZNjwHnQ=;
        b=nHe3H/56gYMAG2okdtmv75OqKtAMkMLLg96S+izNEVUtVBHdDeHgKoti8AsSWEEVp4
         LTSnXa19xyQiyZDO3m4Y4+gS4pHueod/kpq1qXnffEqG6KPe/OwF4hZVKTVJ9OAOSxb1
         NR7EM9NdgUhA5dTiQCs4Ooor1QKiJG+Kb4ax6DXvgLb6RntNiulCqojAaNQNDoP1ViBt
         kYQ35y2k2oor3+0bdQpC1maCyPf45A3fBByWfirz+ifjXwOxGeG0TRfz2GWJfhIBWYJ1
         xY8MZhmt7y2t/wN1xDUQX+jl1P6PWMQUQVTUwhbn8XbqZtzdRLA6ehWfu9ju6+ej4Kwe
         F1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795647442; x=1796252242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0OVfCBvpQu7+LPEH8zPzzFoXUbPUS8d7sUdmZNjwHnQ=;
        b=X2sgPaK15t5joSikZ1xikAPi7izHHjW2SiDVENt/Q1iN8uUiEyg+ekiJDLpSM0tj/S
         yS3ILcGv/TaL5g/J/stlhsUDE3cIIPtwJ5SGUToi0xT6eOg+EWROHwtrCW+6dEEWSHaM
         m5/JKHAGVqY5w3gtTV2q/EQjUKN3mxlAQ03FKH7WyC/ClqgAjeg7IPuxqm2YM8wbIRgp
         Ejg2EOO8kziXCNcfFwAvJw6u/UuhD5mpclFOZmX8ZhmUq+uhuaOzS2yZs94clPHhh7c0
         Z6xMd5Hlhemi0pbeGe4KddC1gk0p15Ywm8+lo60QwWRKfJ46kKs6r2Px0K5YkrhZ0bUP
         uGEQ==
X-Forwarded-Encrypted: i=1; AL+hErGBP0F7Kv3hu/ymP9BHni9psrz+xjwo38IADfZFgRtwrCAdaP+blAdYKzstkeziJwLWyYfo22w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RJ7I7Eez8LpEMQznsVCzjQONuieUJfXrtqU0CAya1sXg1p1zu
	H69FtgX6Y59VvFPF4age89VXDA6FbV/aer/KrbyNpi0fsc8aV5BHLHc6QAzY4G9U9OZozaCdm0v
	il9O55Zg5KMO+2znLOjCPywihTtRYCAvM5yBebdij
X-Gm-Gg: AZFdTZdXFUnLSR/Na2ZM5eB0hv/UDdMgmeCxk7Jhp+tGzNeDFlyRUx/HisbMqwzNIMk
	ue2oJz/PPywuHxURB9HumvRIDImVjaH5yHcQso2u1btBIUsvkxHjciOnb+KE9yIsfQryX5wkdmC
	wkEzRRtiyNIzEqAcPMucvOVZO9r92GvfIZ8yw7UWHp5pIh3SggaouaF6+uwQkF65Dd73xaroXZd
	CNBEiVM1AGrHmrbssXBlitL5mQT3rqwxeHVy0frN8B7I/TsGw3rH78lT9GswAXLHQJS5LDNjxt2
	/AoXWfrywI1WBOOQ0129HP/HYlqy06GxZI3HbsRmCggSA3+bBC2XznTNhv3Ou+cHMtoIpOtdR72
	wd3mPE/KY4+HPvkbei2wEfzjfRV9xtmuWIyrPXYGgChtYJM3GlTUVXjbcpqpHoIwFmNAO
X-Received: by 2002:a05:6102:3713:b0:7ce:645a:13a4 with SMTP id
 ada2fe7eead31-7d7395a933amr10370821137.20.1795647441313; Wed, 25 Nov 2026
 14:57:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125221911.1425213-1-elkin@google.com> <6afabd96-1888-43d2-9ccb-73ca6702a004@kernel.org>
In-Reply-To: <6afabd96-1888-43d2-9ccb-73ca6702a004@kernel.org>
From: Elkin Cruz <elkin@google.com>
Date: Wed, 25 Nov 2026 14:57:09 -0800
X-Gm-Features: Aa3M54po9M19B4zck65Q5x7Gi_mcnDA_E4XC-TXXXd7r8mQrZUfrKezEY8XNZ0k
Message-ID: <CAC_6YktVNFdtDLsNHgPEy-8_2YfZ42mUsuXJ6OKkm=T7zFnxHg@mail.gmail.com>
Subject: Re: [PATCH] mm/huge_memory: check VMA end bounds in insert_pmd() and insert_pud()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, irogers@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 2:40=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:

> Which users in the tree trigger this?

Very fair point. After a quick check, there are indeed no users in the
tree that can trigger this.
Back to the whiteboard. The linter is still too noisy. I will hold off
sending any more patches :).

Please ignore/drop this patch.

Thank you so much for your very quick reply!
Elkin
