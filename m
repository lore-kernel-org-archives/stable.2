Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428691;
	b=X/eWaYEnwvE7dPLbqIvrWWrX67ABPG8es2HYvXAvGP6/ptSlrHy350WKOt3STksDeks7
	 YAw9dTwN9dnycgJ7FqAL8F9d03hu6fB1W8cja6H4rfx5T5rDGhdorkMLPKHwqyklEkjlf
	 zRe1ad+993AF9PS/qTA0t7I78VwghmBAsldA3qYgmIdw8mY9gA1o2838Ymm9G7Un/xmNG
	 2Zk7ZvEna9FUybnR9kl1uZkwVFXXlbITC1hEgf1+mLjkBc6U0+hxUOxciDkY4hmpPvPeH
	 v1pprKWskF5qc/Y0j8huklxKfaCGNW6Bw3J4Vi384Znd+JIR9iEbdcYp8HvdeR9I7Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DwLiyOh05b0NI0/gh6SV/G295VOAZ2Tu2Ln3fZH+sNU=;
	b=QbK9iimpoUFN14j7bO+PEmK58w9XOxs1hyAYet+NB5CnDRJH2rsLVXMxOjSuyf5SCzSN
	 7XT7k2+hSDUyskcRitCIqHw8nUSGkkcT9O7HRtBJ1MVZCGLt/zTNDpeOOg9G1PuVuyThE
	 OrmoWCEsZ/r5Rt+bZSgOt/rjWOLtfwuaxrjm3tEZDXBPItiq1PoswpVqsXnIEzQtbsaH7
	 4FNO4C9r+1H/qpI3LzrnIgizqwvJ+iQhHKslNMZoAA5tHL6G3DWEz+r3HA3PT1D2zMjjW
	 1NKZmdmMPwZXG3jH+/iDWab9kCpc4C2Q+KeXoJGW8bfbWS8rlC5rdpROwR4c0MNsmXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AvOcnwmB;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6130606A33E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6130606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AvOcnwmB
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4b52fcb410dso150771f8f.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 02:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795428689; x=1796033489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DwLiyOh05b0NI0/gh6SV/G295VOAZ2Tu2Ln3fZH+sNU=;
        b=AvOcnwmBq8inbiI9m2mNOhivNjDhZEVTlZDm2Ioz2x+q6HJmyvypkarwgoWjRWm0RH
         W7yDiHP3z22XFL8S3A5Rb+7TwkPsJf16FwO2E7VKKN2UqolgvoUAI+JXj5atwduzju9H
         OjuUd45u7LEXxAGUyCOHywYEx5CANlprVkxJw2OVA1xTJqcOlUDr5ExDhs0oBCv3CG/o
         TKwY3J3xacQ5dlCQ+7L4UTJJbQL0bxCvj6J5LIobbCngEdB+hJuqbeHHSiaTic6gLg8P
         gIF+bH92BY2pojuZMvGvM8LXsM1JnuQ2tGNdEtDhK+OV46jxW3kexYGxUCSgqpxXxSfn
         IfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795428689; x=1796033489;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DwLiyOh05b0NI0/gh6SV/G295VOAZ2Tu2Ln3fZH+sNU=;
        b=g3gUU7IXEDTtTZGSPpJpbTTlCunrPJUwS+COUUgk6Le2cAtTRZvXEFCQLtrqrcBp6b
         GKAOBvduz0MzLGWSeXuAspuPFy7rjrYJT5tURXOihqdcyOsmasgd/04MwtGacqNWpMZu
         gnv8SC2XfRa4yY2YSMT0FtZHawBwAktnLbYLo7c4Yo02ZBiHE/6dY7BK6YoVB8K3/9hX
         YFr95GmsbU1unDUm8i29bH9dvGEV/JGn3XmHvZo8lhDQpxYgur5NKDb6YmJAqG2oZvt/
         42KnPQvUWxvL/YUEABJjAtvQ7TXo4xi5BMV3EvtgBpwEc6vO8kPFj0W10qOJJCw4L7ut
         V2Qg==
X-Forwarded-Encrypted: i=1; AL+hErGacyicZpvCcaowrplaYB3Qtc6BD7V8iBsN5kZX1xgk7t0JiVTDqsgvfwNHoGcWW8kk9cENKrA=@vger.kernel.org
X-Gm-Message-State: APuU4Z88gR3WVJokfEqzuuvoxGgM4/yEHEvOXTplOPzsSbxqjCE0YuC1
	IgWFYHicn2jzRiVZS5nBSHzfsnZcuJXdHXss1h7jm4ebC6T1fqe29KnV+zLCHNxBy8w=
X-Gm-Gg: AZFdTZcnkchM3d/8nbwa11VedP7kZw8ESuh6A5AOl9jXOJhzFukT/vZiXA73SvdyATr
	p5iQcL5NEMcS1mVBVegmUuD5QysLF5GEMoKtSYOzYx2HH5nz+GAt/VnfpFdB5UpbFKYrRx3hAeT
	6v4d4x2UCecaVkPKTFxHYWOsjBKGH2ULASUSrIiDXdC6eL4Fhx9zi8lDFHCSYeIfxZUgHdECHRb
	eAAweHnU4nw4hreh7Uxp7FJPOFBPru8CdZ4FmbhNPlzoWydUyUQv8Bi8gZL7/5A81uxnLFKe5di
	uuCQ5c5//k8jTZ+WcUcixmZyrSYc7RlHSa8ncU5u5vR642ysZg1um/70tBb1F7EV8Hd2LT0lh1K
	4oe7FSRhzHyR87Xb0e5VF0ONbLtUFKWfPhBVIvXPF/rm7LADGrZ7erqownvMHy+u9qZ4eiDDgoM
	tWf0qcarvADgp90hzqVB94m9Uu5Fpy1bw3d0CjmqHUZo8tXZJoOW2iaHQ0utylcXy4MpkgUKU8E
	8kolq8hcQy2wDp7IDXI1CpW9vxs6OP+8h6q7KoXn1jbR3Fm6GuLlDrTZ3e4jPSu0NQgYzZliiZC
	vCkmt3pDURbAeJigb5GP+vueUD8pQGvM+CsNQHRVzqA=
X-Received: by 2002:a05:6000:2211:b0:493:72f7:1d5b with SMTP id ffacd0b85a97d-4aa5b235116mr26571679f8f.29.1795428689306;
        Mon, 23 Nov 2026 02:11:29 -0800 (PST)
Received: from localhost (109-81-82-199.rct.o2.cz. [109.81.82.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm24009577f8f.24.2026.11.23.02.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:11:28 -0800 (PST)
Date: Mon, 23 Nov 2026 11:11:27 +0100
From: Michal Hocko <mhocko@suse.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	penguin-kernel@i-love.sakura.ne.jp, tj@kernel.org, mkoutny@suse.com,
	chris@chrisdown.name, cui.tao@linux.dev, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, zhanxusheng@xiaomi.com
Subject: Re: [PATCH v3] mm: memcontrol: don't miss processes whose leader has
 exited in OOM scans
Message-ID: <awQRT7InNqEF-K8-@tiehlicka>
References: <20261121073222.834282-1-zhanxusheng1024@gmail.com>
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
In-Reply-To: <20261121073222.834282-1-zhanxusheng1024@gmail.com>

On Sat 21-11-26 15:32:22, Zhan Xusheng wrote:
> Moving the exited leader along with its threads came up on v1, and
> there has been no answer from the cgroup side.  cgroup.kill had the
> same case: da13e0e72a73 ("cgroup: fix cgroup.kill for exited thread
> group leader") walks all threads instead of the leaders, and
> 5f4a3f743acc ("cgroup: don't kill migrated processes through their
> exiting threads") then had to keep an exiting thread left behind from
> standing for a process that has moved out.  This patch does the same
> for the memcg scan; the second case is what the live_elsewhere check
> covers.

Tejun, is there any strong reason to keep the exiting thread group
leader in the original cgroup? This makes CSS_TASK_ITER_PROCS iteration
really tricky and error prone as above examples show.

-- 
Michal Hocko
SUSE Labs
