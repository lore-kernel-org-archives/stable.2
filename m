Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434566;
	b=0SGuCCTfxK2J9wiRBmkPXXIjpk8cL28kiWjwIRODJoKZ2pBhJPFenvNiSy704z/oQIA7
	 D1k5UyDE2rZs3GXXR7dXDwHdePyEYvYPy345+ScPQM2908f+NiJANqzrzQ5WgNUs5r6XW
	 TmOVCAChBZSYRY4PJYGqTqr6wAGwtbOboEouxGj0qUqY0P2ukBqXX9UMrzvtHN2Z8UWTv
	 42dYAitA8BLFpjfxMlucn2y3PMUbNWKg0tmXZTzDTVNvrDwAXdmCcMV8b8GqZNFthEzQL
	 emnYu+HNO9yrspxBDH6TjuuDbgrG/E/ZsPGxhN2BdJNyFI92g8j5+SN62fbtWaFph5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DLWiLwlOa1M+CGXscE3EqyDLFhF6yXj7XzInNLOita0=;
	b=2ZJMGoTt6rJASnfkFF1O/se3iCH9mXJsV/dCJqGrqlUEIifFLaOrU1wtKX0Wf0P6+Cm/
	 BgsCCNP9uesHyM4XtuXA83SoK5sG1LkXHt1xUZ4h8TzFY/zJV7zKF5YJbzL46CDeKvSvP
	 yKucd8309FxuUAfm0SWM1eOC2ChGHd27+kftd39eTWQ4eyo4vbWiGfpZFtY6nze53cXRz
	 bA2JCaPCcusqKlPnRGEgB4yxER8R+Hf1zhjNq3YVKIk8Li+49L0OfCG8kX2auoPn+4eCR
	 JvPNlARVBBbLxxK/j8twpv8ORjKtFF5BpkqYBUH8hhJ4eY42MEoaQ3ZD+xomRTK8LMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=COSYS+dN;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F08606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F08606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=COSYS+dN
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so13340985e9.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795434565; x=1796039365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DLWiLwlOa1M+CGXscE3EqyDLFhF6yXj7XzInNLOita0=;
        b=COSYS+dNefZdqkxEJffuyhbTfHZeKxak1CQ0RmWdfYG/c4CrsOyFDid0VbHd6UUsK6
         ihEatHsLxMtusANsLiY+BgbJWxgE0PZCPAKSrONc900gvT48RIc8Lt3k0SePhL0EuiLp
         iCqCg3WaH4eDCOQK8gwwQKfI6QaLrqVWzUSiGeq68HfJUxeW29GpVAZrM841aJlBK3J3
         VonNZrihmfRFBsNBIllmKxy2dmE0Ibd6NPiXIhAoAP8BLZwH0BERyiIkBynx2L7Is7U8
         aUrhCKZTr+OpE9Kc3GhxM8evfIqq7RvvojUPrFA6mQOInvzwjBi5bS6SuKvShmskXbMm
         v9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434565; x=1796039365;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DLWiLwlOa1M+CGXscE3EqyDLFhF6yXj7XzInNLOita0=;
        b=I0j7jwonVByowY5918cIXapnMYdKolyLz3VRDGLAr23Gn/7WAS/3T06m3DkWacIYE3
         8xlBe+a9LgiXduryTLFwKtlIA/9M+tGzqHB1xBBVnrOHQp8kFXPY0Y3dDBJ3yED5mjb7
         FnFQzN3Eb8qpLX+cKVU5ikwDQv925YXFDWO3TB+t3CsaVc66XBVlm66urZ+xVcM+i6RU
         b7hvwKCHZGMFr9SyOLsAlNbOVp1o1Ht3TA33F7cqgh5+IV3UYzwsv+0PyfnNR/Q48vAC
         aCFjC6Yt1g2Ivm6JK0lQcvs3hFhW/5BKX/umldh8Rm/4LTXdi2UJxpSOyVDYefo3muRD
         Larw==
X-Forwarded-Encrypted: i=1; AL+hErEr23xyBU5OK+Fj5ZoSBMoGiGjB9TeNj3cUhkwVPyKpjQc2Wp1Teosyo8NuHL+008HF+Vojzlg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s3ApZbeBASeIrW3jdXlazUepbbwIcL1Lm3enITbI4reVXG7fy
	lzHCKwnvlTT9rCXD7w62ulj3aXv4VXYBfrSdBVzYPJVcJkeqMJAh6toHzh74CsICRe4=
X-Gm-Gg: AZFdTZfltwTTO64hvs7SRG7zJYlP/PuBvDLlbtAClCUgvoLKlsU5peQabflrCipU8Qy
	5iesKkw7NFOaY0rvmTOvf547gbT0Igx5bjNh341Rq6FnIvFE19+sP4Cm6zXXhKbaw/cn1na8Ftr
	VrhYn7kewqcZELIIhnJ4+7m+JUQ0yy5vtT0grvJFj8Y7XQ0/xusNywtipd3rrOsjSYKIOYOApU6
	RBpmUIwZfRYWkq4wJr/rJZtq9uV8uPChlxUKPYkwNBXhRANcX/nt2L4dKYoAlLfyuzBbTMhSjxd
	gcReB+xyQR+Z0g/OVh7KKEz2kNtH6LPn4xuoLsWMmN/w0VNd1RxMEaUCB+cl2dx5Kx3Es9HOgXF
	91dN23KmcwGcs9MhISHIwGo3SSvAHiD+XTXxE9LK6m2xFH8CiBH+aepgQE+Y9i2OU9z7q20PdnR
	PQ5WKVmBZ+MswaOwDLHAs/uXMkKQMiopIG6GgMw/R5GdjUdG+WBqbMDVsTzpcPLrNsZxcuxM5wE
	EALOjH9GJ9uJb4UUE76aAsSWjvI1iKG73N1Pv5VvzXRZO9hq8RwPD+Pl+QDuqKv3286WR9HG+lV
	jqlqTSHt4+Z3A0FXQ46RBmfVpCKfubwqwypWLsdawc4=
X-Received: by 2002:a05:600c:1911:b0:4ba:38a9:85e3 with SMTP id 5b1f17b1804b1-4bb8880eecbmr256789465e9.12.1795434564856;
        Mon, 23 Nov 2026 03:49:24 -0800 (PST)
Received: from localhost (109-81-82-199.rct.o2.cz. [109.81.82.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865b1sm337727695e9.5.2026.11.23.03.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:49:24 -0800 (PST)
Date: Mon, 23 Nov 2026 12:49:23 +0100
From: Michal Hocko <mhocko@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, akpm@linux-foundation.org,
	hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	penguin-kernel@i-love.sakura.ne.jp, mkoutny@suse.com,
	chris@chrisdown.name, cui.tao@linux.dev, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, zhanxusheng@xiaomi.com
Subject: Re: [PATCH v3] mm: memcontrol: don't miss processes whose leader has
 exited in OOM scans
Message-ID: <awQoQ4Ib9nCcK9Z8@tiehlicka>
References: <20261121073222.834282-1-zhanxusheng1024@gmail.com>
 <awQRT7InNqEF-K8-@tiehlicka>
 <305c5803b904a57c188b505d6ed9e1e4@kernel.org>
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
In-Reply-To: <305c5803b904a57c188b505d6ed9e1e4@kernel.org>

On Mon 23-11-26 01:13:25, Tejun Heo wrote:
> Hello, Michal.
> 
> On Mon, Nov 23, 2026 at 11:11:27AM +0100, Michal Hocko wrote:
> > Tejun, is there any strong reason to keep the exiting thread group
> > leader in the original cgroup? This makes CSS_TASK_ITER_PROCS iteration
> > really tricky and error prone as above examples show.
> 
> No, and I agree that the leader should follow the rest of the process on
> cgroup.procs migrations. It's this way because controllers primarily care
> about resources and exiting and zombie tasks don't matter much in that
> regard, so migration skips them and controllers don't have to deal with
> them. I don't want to change that. It doesn't make much sense to teach
> all controllers about them.

Agreed!

> That rules out the full migration path for the leader, and moving it
> without one looks fragile. If cgroup core switches its css_set without
> involving the controllers, ->release() sees a different css from the one
> the task exited in, which breaks e.g. pids uncharging, and that still
> doesn't work for a leader which is exiting but not dead yet as it's still
> running.

I see

> Maybe the leader can pretend to be in the new cgroup instead. On
> cgroup.procs migrations, record the destination css_set in an exiting or
> dead leader without touching the css_set it's actually on. When a
> CSS_TASK_ITER_PROCS iteration finds the first live thread of a process
> whose leader is exiting or dead, it looks at the leader and visits it
> there if the recorded css_set agrees.
> 
> That leaves the leader's actual css_set and everything that the
> controllers see as they are now. Only the iteration changes, and exiting
> and dead leaders are handled the same way.

Makes sense. Thanks a lot Tejun! This would allow to use
CSS_TASK_ITER_PROCS for the oom path.

Thanks!

-- 
Michal Hocko
SUSE Labs
