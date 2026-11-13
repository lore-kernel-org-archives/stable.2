Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558004;
	b=HKFevlpUEshGBNjAuv964mdqYQK5IoZS+QIZ3UUocIyIrd+f3j+Dft2YAqbfCqr5RsfK
	 9fBcrFV3KgSS/piLXKquKEHuijnSLDe0MDlOnbbdpYxVVB1B2/+3DuOfxM4y9YUkzNrjq
	 KO/LVZdqj0OfmTSmlQtftv8UgVNQ8KTAXe0pSOFcUZfY1NuIRrWyusymO16+fIQlYP49O
	 h3Eed2MX9YcS/aNdbtFHpQco52um+4ISYcVyRcMNOVZvYm1Vwx+ziQ+TnakNkHKTcpBdu
	 MAK4LKyMnp8UXA5eq81D2wOEPrPMOGcjWtrnlvyV+pho5NA5Yvg6QA+7a5ZarZt2RXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=u6ODy5SnsRQugFSPY6vBQTFSWdeeo67enpuBFMw2vTA=;
	b=Ph16L9eOnyV3FENM2ES3uD3b47ZkKQUgmG3/eBRBq5UszQpXsx0VKgq/glUTXTdrcQq7
	 WI6MbYKTPwvlYjFcV/e5icJHlLklyaWejXaRImlpYaEIlOVCaRvGmWs0ziwPuv338hitZ
	 kzLubid1Aei33Su9B2XT4f60zD63g/RZ5S5RNecK51pkVah2mU7FIzWb9v2MaOnaCX2st
	 XhK3DLpY+CJAwkh8KpdtxWzEHEMCCxkdgdiyYyuAEsgS49U34W5rxf0WmpwRiZVvIcssY
	 dNRrG2BQDeNj+OJLdH5IMosb1iQZSC7uQ67rPaMGGEf8G6HTTvxtsy09/xaIldr9W0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OGJEvOtU;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F7606A895
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D8F7606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OGJEvOtU
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so712567f8f.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794558002; x=1795162802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u6ODy5SnsRQugFSPY6vBQTFSWdeeo67enpuBFMw2vTA=;
        b=OGJEvOtUEBShLexZaoNIEU0Kv8IFFc6MSOKErs9nl6AT7R1oYdts6gSObwQu4spiUg
         PuagTz6s+qgS6+pEfJDcBUMrEB+UeARXCPje500BpFu8z+SnfHkrdQY32QSPeimCrmIK
         fBfyenwoh3fJtWsIrVT+kDdKV2r8W9RBtqTq2mwmiI9x4dXCZ2xC9ZQVvFuNQXwjs2Mc
         dMMrYCaybPmLrMqxK3OOBmq9ZiN0q/NxNUz4Lw+et1VWbWIP1NTBbD1fohcIk+XdNpYR
         NXcP2JhODHgUbxvu55f6+W4qbduZASDMaMUrYHPw7Ykr5syj6G54Gmf1Gof1Pmwzphuc
         7lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794558002; x=1795162802;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6ODy5SnsRQugFSPY6vBQTFSWdeeo67enpuBFMw2vTA=;
        b=yA7B27Bqst4w71Hm/jQ1cFGdWB/oeMW4ItNk6nuWXoMSxOZWzZYs8Q+G5yOY/3cvGg
         5zW6/ZpftHHkJ57Bu5LrE5P8e8EZoKPbCKwjC6DhDKZAHRzvoziX+X6gsRJe7OakryUR
         4S8jFqgb3Y+Mb8uULvihpJU2OeJa8iD5FJHF99+YkhCu+FiP0lBn5Q67KEf1rFeIs70+
         4NCV5kCmAFg9/M5GKSywA2u3TYNPzK9LC+YZyWPH70Exd3qzOYhnUkEUKFZwfR5jrbMn
         bJFOOpNyCbPDwc07VkpUU15OAm+hr0q2/TXf8rU3hePH5hHlyeK/4pQBeAw5tB6pwZT/
         /eVg==
X-Forwarded-Encrypted: i=1; AL+hErGSSrsoaf+hGf6iQcazmMBnQbBxCpkGZl982lMBJa5aEXJ1qjqIavGnwgcoLhOnbCjX2GaWD0k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hGQ5AImuGHFr5ImFSjbUFVSF/fRR1mE1z+FaIh1gmpUt7MUlJ
	t1mfhC4ay+hj8wXRthk7PVuTwzwEfwTQz0IuRN6Bfp+4n0DgGJNfDc5fYaDIL3oSsbw=
X-Gm-Gg: AYBFou0p374wCszAJrXv0IwgBnW/unVh4AZ6GfBnTLq1wtwzwjx3mffLACh7JmFO1PG
	vO2iiM/v5y0jYWNfk9ZajmXlOedAbulgRxIIK34e3mXQxxffhSFkuPbNsgKIhRCXqkRe7Euv0oa
	LUfe9IYhb/7Km8Fj4t7dsk4F/FDz1gQn1sWHc9S72poGuH/wCWNA+vUobjbgYiOJsYG88PBo8mU
	WmIzQlL4aP6v/T7qae0fYY7wgBlxfb+T8+9DPvxtxv7A4qMpz207aJwQB1yyGlDUqF3xItkf+xl
	SfFQWfQAXeTfeyWXczpKz9+RTLmKcYHwuGuFqhYDeXF6rOLzFNpk3LPLs1cd38CU/8EBfMEreCn
	IMwXifXgXoA707f22OdU3Mkd3oQUnt/H75qeia5lPOCufpQUY4wS3TvbTTW0GYjpokg0r3/HN0m
	uzDu+xB/oJBA/slvP241VVXf2j0K9XF/PjTa/O2HPWQ9vwYC/UdjUGZPAqVrWrY8OrNdoyuIMxu
	hSJmwjF7yb/FlDAb6o5G3mmhlkzU5EqrHrvsJLmgo9060mI7Jowm5I3OMKQ8EvAJjwHLjaIISv0
	K4Hn8z1BOfel2ubvV0oiE5QT/xDfD1knPiD0r1r4ckE=
X-Received: by 2002:a5d:5d86:0:b0:48e:43a:1d84 with SMTP id ffacd0b85a97d-49c712ac267mr3929586f8f.23.1794558002001;
        Fri, 13 Nov 2026 00:20:02 -0800 (PST)
Received: from localhost (109-81-94-245.rct.o2.cz. [109.81.94.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c602dsm3640220f8f.46.2026.11.13.00.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:20:00 -0800 (PST)
Date: Fri, 13 Nov 2026 09:19:59 +0100
From: Michal Hocko <mhocko@suse.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	penguin-kernel@i-love.sakura.ne.jp, tj@kernel.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH] mm: memcontrol: don't miss processes whose leader has
 exited in OOM scans
Message-ID: <avbIL86R61Lu2YVF@tiehlicka>
References: <auhiGqKJeukk7t3P@tiehlicka>
 <20261102114029.1259655-1-zhanxusheng1024@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102114029.1259655-1-zhanxusheng1024@gmail.com>

On Mon 02-11-26 19:40:29, Zhan Xusheng wrote:
> Hi Michal,
> 
> This is v1. v2 [1] reworked the check, but your questions apply to
> both.
> 
> On Mon, Nov 02, 2026 at 11:12:42AM +0100, Michal Hocko wrote:
> > Is this a desirable/intended behavior? Shouldn't we move the dead leader
> > along with the rest?
> 
> Userspace sees it too. After writing the PID of such a process to
> dst/cgroup.procs:
> 
>   src: cgroup.procs = 85       cgroup.threads = (empty)
>   dst: cgroup.procs = (empty)  cgroup.threads = 86 87
> 
> Moving the leader would fix that, and memcg would then need no change,
> as the PROCS walk already returns a dying leader with live threads.
> The catch is that the leader has already gone through
> cgroup_task_dead() and is still accounted by controllers: pids, for
> one, uncharges it through task_css() when it is reaped, so the move
> would also have to transfer its pids charge. Tejun, would that be
> acceptable in the core?

Do we have any conclusion on this?

[...]

> [1] https://lore.kernel.org/all/20261027144016.2582880-1-zhanxusheng1024@gmail.com/
> 
> Thanks,
> Zhan Xusheng

-- 
Michal Hocko
SUSE Labs
