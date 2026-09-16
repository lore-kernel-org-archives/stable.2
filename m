Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E2377A8D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571981; cv=none; b=FzhbFyZMwBhk1F+Pfx/15SCFoax0mR0/eJaEvdW/K2WwNBcJRZPb114HBuQIctCoXVj2iFWyosVWQDZ1J+eIBHpd36hoiNtkOpTRn/aB86QfWqRhLzX9D7jD9nTCH+qitpi8uiw8x8clQj73YM5G75ODBtkfxsmZoU4VFuZlpu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571981; c=relaxed/simple;
	bh=Bd04q5qs6Pp42KGej2Kz0loIBOnLQGooaDFK4aZEIJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gecI9dquIwW7h5IXmhCrVNW5H22w5O/ncNqkFICxgAfeJG9+V2cJyDYVfGU4iuxbzVmIOzy4KDRdIR4KpHgzUsd4J9ob5K5RqzwjoRIrdJPLd18Jn/cV4dRQIvJLtMMj5hPTmMil6psmP41F2dz2eokwi0c2tnF3OQAhkrOttf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BACNNE0X; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BACNNE0X"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-530e28a62abso13094441cf.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789571978; x=1790176778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VpNPb1TxYXca1d4OZUk8cPR+2lzT1yr8aN9KjQ5b67k=;
        b=BACNNE0Xqy/Rl6Bfr/VLgJYpoONgFWFRN5s4uaN6JJXD6Qri79ws+Azw5u7E0YD5M5
         9Uob73NNG+cWlVvnsEJigtih0YfuG7m3VyV+KlDpqP8SfxXtF3kvENbkzUD4NfDw6FDX
         Wv+GXA8G0SfFJP+pH22OoJxYPowJVPXPzKNG4yt+zJbdt8uQsG6h0a5R33CaX86FEQok
         H2idjs4XNSGSwMYwwQjSstlYE0cruav/qGcjewr1yyet9r57ab3hoYLYh1zu5yIMHWNn
         NatKYiY8u/d8VdOkNLNIqHAJWGjP91VjGYyv/G7p4FgQQz8oPf/AMOtKoWW+TPWXVSlN
         l9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789571978; x=1790176778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpNPb1TxYXca1d4OZUk8cPR+2lzT1yr8aN9KjQ5b67k=;
        b=yvXvMiKqcIVMo55BVpQg/QvU7NLi+q7Q6+DeHc8pF7tRPU8NcHMgIVfOU9O4wa913C
         CgI7wLwltKr03EmVgGCBOjaNQW9LsBfyzz5wT4XrT82cbK18OwvoQNknZnqimXyzLwHJ
         DFw04qV0JLpc8r1PKnYFLT8VAJ50IcI2bKav/4uylgToqJCIruJDpAzPL0mWZSA9a+hv
         9PtRF42x7JzxNVh6x+MNujAMlqa0O/WK1RwuBlonyk0gy2QU6iEwFwDZnPAfQBoDDerO
         ind+Qa+h54paeefQmRzoO89F8sgGY6bMzyxHaAljZCn+stV6N+bqbQTaIkiFrqDYE3Md
         sFdw==
X-Forwarded-Encrypted: i=1; AKwUvByScXLlgmo5zitjoe4Jt7YGRQeo0gs9x2vpSNPomj+KyX/iY9XxewH17rFw0iQfJZhKx6SmWA8=@vger.kernel.org
X-Gm-Message-State: AFuF++n/T+S9YAN1k0BHvt5mU3f4/THyiVN+RKGCQkUMfcAEcrq9OVD0
	DjT/Z7DgO6levtenjgUS8SRb6QWnJywr3MPaE9ZeTh7Vj+d4Dc/7TnjaHwNhSY4vAag=
X-Gm-Gg: AYBFou2damHZE0uYMXq21aeaHyqTXuHe2t4ZwgNOYXgFBS+TkC97jZpIp/oxNEanTZN
	9cDTmo9Tr+oolWpu9BsR5QrwHDAzX3axEKyX+mRbTV4KvcgfkKFiC6GE8tEhgBW4s45priI4nap
	3E5cCEe4tOiPhpjSp63Y3+GL6OUIaDlCij72z+CJovmKBpH/fSBdO6auNei3yJeDHk/bjyK4kut
	vQ4XgDRQJiYYCajlx8aHKzAXKMkESWxE01aqMeFl7F4kfzu7Bi/hprxV/e4JiFlQI1/u0skOJTK
	RXy/FBh4tHyl2F8bnTsuCW885SmymWNy66dHDesL/DqsySKG8R+e8/8ipm3DxI6B1GK6/EBLNY5
	Hlj/imCt4A4gX7FoOye1pMTRfRcAzd9vu6//bWYkvlyA0HcZdA2Lx3zS/+rWnDmCGJ3h+7qh3/F
	dgMPLvYutA0I7VfGocqhdJc+tFIb7+sUt222tl8AzUQ2vyMwYsYK7SgqUG9oThODnO4A22IJe/i
	tD4xt/WawB798lXtF7MyAY9RzpBt0xXoF4lmCikiMQRPv4BIY7dhiU=
X-Received: by 2002:ac8:5f0e:0:b0:531:2154:becc with SMTP id d75a77b69052e-5327eead6e2mr49713181cf.22.1789571977900;
        Wed, 16 Sep 2026 08:19:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53262024a94sm24051881cf.15.2026.09.16.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:19:37 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:19:35 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, jannh@google.com, wangjiexun@tinylab.org, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqqyhkZqcXDUrzeb@gourry-fedora-PF4VCD3F>
References: <20260912110832.3203902-1-gourry@gourry.net>
 <aqloB0zm3RjJ47m1@gremlin>
 <aql65IhMobL5Al9B@gourry-fedora-PF4VCD3F>
 <aqqTbGMJL86TzDrf@gremlin>
 <aqqbB_nFAOGenDhy@gourry-fedora-PF4VCD3F>
 <aqqjW5dpyznijYLh@gremlin>
 <aqqk89oTigJ9LS2N@gourry-fedora-PF4VCD3F>
 <5437871c-d9ee-49d2-b24f-965c73c29c3e@kernel.org>
 <aqquDtEZL1ndymGN@gourry-fedora-PF4VCD3F>
 <46d923e6-5724-4df6-b0d5-8dda7c547f6e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d923e6-5724-4df6-b0d5-8dda7c547f6e@kernel.org>

On Wed, Sep 16, 2026 at 04:59:32PM +0200, David Hildenbrand (Arm) wrote:
> >>
> >> I told Brendan exactly that (try stubbing it) and he tried ... and had to give
> >> up at some point because it just wasn't feasible. ;)
> >>
> > 
> > LLM go brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
> 
> No schlop like that please, I don't want to hate my life
> 

You missed this part:

"I'm trying to be careful about not causing a bigger maintenance burden"

I wouldn't do that to you :]

~Gregory
