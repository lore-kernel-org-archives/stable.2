Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101048;
	b=toXZcwNhboWMHMo6wV+PCco/0MRE4EEb+wMt0GMiKFmwV2CYwnGyoVN2yQUdA2pFFANu
	 eHLbU9ISFsnc0cRkbFpfAQ7kJkKG6hNqSU/vLfg0hN091SAnk74Vn9q5GHFNLDbGSRThv
	 o1zd6AiVCqd3Objx+knD1sx9UJ0vvBUePY5r6h69GcV33sfFBlqWv098/T8Y7pKDrQOQB
	 u5cnZ3/Dl/7kd78/yc7l3ZM50/eVt902VnvuJQ6Porf5PwI/vcMBrIHKODxYIPrN5wDjd
	 vyPvb6ljdOmFq7y+ebA4Nq0anOJxDud+aZRE1Vf1og4t+lXoPaCOwSV+95iRv+mi/MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=B0AENkjEZYL4fzS8mYn3YPtPPkm4rS6Tf5gq0kxi7XY=;
	b=1ta/4EGo/1QMiTqe/RbhAdn+/lWARdUuzjPFomq2qD5v1pIXihvluM789Y+GKB7NOD6U
	 i2gEDjPwmCXb86l99y6w0yhkDcn8N9eTeN6GY0rqL1FuQ81qJBjAKbXRIGtUVdVoVrstV
	 355/6I1pbpsYj1y2d4gaMKqOHhJoQgUBLcEQKdya/V7FIiLplPdTEKrPcVy7IK+Cj2QrL
	 Rj6dCbLDAPTeQjFylprpMtvne7Wb4LOijZyAquFLnjBforIureIbTq17A7Yh57InjhXy0
	 2qDIQM/+cAy2F6QXyENUi45R6d16X8fjGS9Sq2go3LLeAB9PY+ogbnhe9bh5INStDnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=cfVq1BF2;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF01606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CF01606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=cfVq1BF2
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5363c8de563so40505781cf.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 04:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793101047; x=1793705847; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B0AENkjEZYL4fzS8mYn3YPtPPkm4rS6Tf5gq0kxi7XY=;
        b=cfVq1BF2EvPw3tStOKBPCpXo9c/BBUUyyLctzvWGZfXIYp+Z36ZjiWwM04mKSKiNDJ
         UfdHl+ZMucUt6/4nx3kBWvhetR0TY2XikuDLZ8y7+3QHgzZKSMS7eq9OfPPcTIPnKUUM
         gQCm2OsVLbZwxpU9arpxabWSa8OO/oc24WYEeYJZKZMdyawBegk5BjAmOonH19oYVLCG
         zkcVDAba00f+7GZwDA4e3lpt/AgTyZ8L/qR62eRLdgNNjKQN+oxm4UYZDfZ7z8TAdGIL
         P4sowfYMyeQMSh2QtqWXPWk+ZhX8I2LVshVfvLy/yhyowPRVJWOkh38qV0UUQeyy1Ao0
         7JJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101047; x=1793705847;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0AENkjEZYL4fzS8mYn3YPtPPkm4rS6Tf5gq0kxi7XY=;
        b=f3tbF31vPsuOC+pW0vGr2S1BNNJLMkmoB273w9BKm1ptEf4U4cJ7t3WaZF+R8JpAJh
         6hGlBRroUHvD9al7UzBDheLe/StJkJGrI/vzmfGU9ks/LVTUOdcC4BkexxNbC2manQOw
         /Ojki5kNlHHbZalrvFGUlGpm6hacsI/mu0NawrLKWtQ9vTSmNnITvf5a0DHYx479dqrx
         LxH7rXsMILhVriD1eaL0x/AOidI5YsYXzQzBYDBnVOypUSlXm8w0mcMtv4vXQUh5lc/F
         Ry3Rss+JFAg77AnO0mp/SzF4yFwzmwIJ42Uu6UIRc4JV6TJMaYP5Gcr4LmGoAa4B08eN
         vgpA==
X-Forwarded-Encrypted: i=1; AKwUvBzO57nEzwLQ7aG+lx1uoYEfm30TIZbcoxOQ4uoUFBIdIXgOxN06L6PBy4YklDaVv+F9S6LJlcM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgAu4YyDUXRvWQi1eR3jFSQsWnzCSPE4sa5qwilJDBLGSDQ3sk
	SBpbwuTjU/5RGuxfjjoYXtSW88JD+kkKWbbNnOyjYLa4Zj0fCTaPEiNp9DMruIV6r2Q=
X-Gm-Gg: AYBFou0dkvYf4SViTSEH7kq8wu3pgOqR59DpIgCI03z7Xgl4scJxo6SMoEDBsNfVS1l
	rAdAPIoQNiROlOUpk7rVkNt+kClyQ8R82ZlofvXwWArjXlbk7O0A8HFUVLvpy+d7JuOnA49lE8c
	fwcEMiLtQDwOhuVRzmZskUKr9Kkx/reNY9OJm1UZcA/MKLLnxNtZM+Erk76ndD11FkOOT77dtdo
	x4SBgzlYp64SMptps8+MuIhHJufF5/fvIAi8sqfLdOAEA4CmcyWhh5oCpf6hQDzHfUZ6R+s2skE
	LLJYynukwAxmeXzv8s8Y9fXNHlp9AznrtfytGNLRmuke8DJEeS86gz+/8j7wD71U+YwGatMoLJp
	5c2ic98xFdVE6J5qkInBdcxEz4OrnGEFt0AJY8i7hqMEbqenNyQv2lFfakm0XQjYDOUNBIuq1yh
	tS10pTm7uxBaB2pP3brfxsVsw3cX+uKOo2QeWfCQhb2CHDg6+WYyq0BbHogGHjHOsMfZNYTg/FO
	GZxEATguIzOh/I3VFIdMvNX7zrC2DM1VosCI64JU9dfUGrLn+O4QAoWp+RS6e1VeIUni0zUCU2M
	NwhHUUJPdiN6VSA2DaE1dRNeOUsa
X-Received: by 2002:a05:622a:5e8c:b0:533:920d:7bf8 with SMTP id d75a77b69052e-5383b4ae34fmr146287491cf.24.1793101046776;
        Tue, 27 Oct 2026 04:37:26 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53838cf2e96sm77329351cf.1.2026.10.27.04.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:37:26 -0700 (PDT)
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
Subject: Re: [PATCH 00/16] mm/shmem: various (urgent?) fixes
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>
In-Reply-To: <3022ba03-54c6-499d-b07a-2ca8d033a56d@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <at-yaxmjeOXtA15M@gourry-fedora-PF4VCD3F>
 <5d10eba8-11cb-4031-84e1-a394ca5b4cba@kernel.org>
 <179304984259.319828.7383468637599462048.b4-reply@b4>
 <3022ba03-54c6-499d-b07a-2ca8d033a56d@kernel.org>
Date: Tue, 27 Oct 2026 07:37:25 -0400
Message-Id: <179310104515.664110.14057520583832900506.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 10:34 +0100, David Hildenbrand (Arm) wrote:
> On 10/26/26 22:24, Gregory Price (Meta) wrote:
> > On 2026-10-26 22:09 +0100, David Hildenbrand (Arm) wrote:
> >> On 10/26/26 21:08, Gregory Price wrote:
> >>>
> >>> feel free to take or leave the selftests.
> >>
> >> Thanks, no time to polish selftest ;)
> >>
> > 
> > It's there to show the work more than to merge, but the long-term goal
> > here is to feed these tests into a larger session that does the polish.
> 
> Agreed. But a note that if these essentially contain reproducers that can cause
> harm on real systems, posting them upstream might not be a very good idea until
> fixed.
> 
> Well, unless people can trivially generate them already.
> 

Nothing here has been generated by anything the public does not have
access to with a $20 subscription or enough RAM to a run a decent
model locally. Otherwise I wouldn't have posted it.

Posting the patch is the full disclosure at this point.

-- 
~Gregory

