Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686210;
	b=YSoKbULzY+AB2TBPwpWLhS5a6Xgog84X5Aaa3JfVqR2RjaOcF5b7RL5kZP3Yodh2GnpG
	 sPJjwYfTsCImJpek0o/s2I8k+lZ5k5fR+iJ4OD9y9BWt72/tLqkojLAUzrMmWEXA4BzTD
	 nAk3Rnwm0DxMXBmO7RHERIOAlStXCTDKhFQg8EOKPbrdoNaZb7xC76aPraS5t3nC7aeqO
	 Bp4sD7+Uxfl0067FkJQuz9D8MQ2fCl2Yu+NysT9ExREUasJeh+DTXAK3njDY9PZlv32OV
	 vdQvgCd7UwH2SH4MGt+EN6yt+7KEWC89hHJWQRoazHW9EkkNVr37cwjcHzuQvL2Ey8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
	b=G/si9WBgL71a6x5gyHYcQAyHjMMou//gaytPyQ7LDEjuzsGnveKu0QQOwmFEmBS2K+dD
	 deToOcUs264XwyvyboipkAYc/G68qkJvwtGGRgsNxPRwrERjY9XZofId9zGNpKxPQhBWT
	 9HpUR4qm+X5T/wueMM/iJ6ObURA+N9f/MEltdv4atj5m5p01YHujKp/tfarEyyaUB9D5r
	 2A3fSHRjcN5GjqhDMU3TRxKS+TXTnafEXJg8yNy6NqoZEjKYDGKjfo9NnmJ82INys3KHk
	 OmYcP51JhVrKNzdvvhAtdTtJ+daXk2mAszQdlllz2Rv4u/HL5UHfdS+2ATsyp8Ztomg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=g9y4Kqb3;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91160A2605
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E91160A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=g9y4Kqb3
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so2154646a91.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686210; x=1795291010; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=g9y4Kqb3xQZI5SfaQLRCJwnELO9McjXi+OC+lVOPwHgkeuPIjg+1PfX+vH0l6xQNu7
         dRhgS0vAAYbAAZpE+kYQ5ut93ePMChHPG6ZsFT+1wdwe1h9GWjXo7R+0ztE7D3hatwi4
         1rEtUZ+u6XMtcwrwmcsaO5RNfFK500Dj4GVhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686210; x=1795291010;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=ZxOEDs/8w0tmhxpw+83h7ODH4wD5V0PoXpnnRgiPYp6QhQQhA2Ttf3CYNsCZHzy1jt
         gvAvbXHzRadJLkhXKInxHOAmwDYHYASfBNxxF6HuMLXua8L7SAUXXUhv+7cSFpC3G4Yr
         qMh4SNgW1IPG7QoQ1LKwtiPSnWbXh6X2wBaaX0wEwFb7xrcHcIQ3uo5EURqzS/ouamQi
         rF5G820q5KgraxMylRCU0TjwDVLdGOOUSOFG0wLv4JOL3wsoAYbTRof8G77G7ltadP6D
         yd1XvORol9OO6Hk72sBf8oDYt8T5BL4REn1opHnr5w3ioDK2um4eNe1duwyoaIvLZmQN
         U43w==
X-Forwarded-Encrypted: i=1; AL+hErFpRymtCC1GX2j36JOjreYQB45mDfqEV7+lIHZk1648ZumwWy9g7gPiLIXdRiuG236z6Cj4N0E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8DbOcT1eQ1ZNLcp3JgMTT3VIIil1Tyq9bfy+zoPZMzTP7Ixzh
	6hmgu1hcFPbLbEABYk9c8WFYdyHvHWFyRMamovs+G3ku+lcAp8XzPc3O46C1/JhPJaI=
X-Gm-Gg: AYBFou05a87mAiRRiOuuM2HbXGsBB/uZfQ5igxRFBFwWDxLUJbNwQXlukA4xk3jY9Gh
	Nu777lNxEKnC7ca1AuhXypwU4KhJs/e6Kyl0xZNVRdsEI8k2ceQhNXOzlZ1WXqUx7tslTyrgBjA
	JRrDRD3WaXIvIyriShQMffXflM7XWOPmSAnVDYUp0gMYcqK9OxtE5mCQE0OQRAqHDQyXfU+5pjJ
	rV61Ee6r38AUDmNHXRKp/PRDy1e9v4J2wgz5OKp/T21LqlhGv1IeSsDeW+3fkE8kGi3wMMISD4O
	yNts8ULVe6CpofUMj/Cwv1fl96xYN4JMejzsuKrAL0/tn4iN4g99C2qpnaLeZ+9zxswmt2MMLpY
	GwvTltPxJOnY7KnwCn6j5yAJR70jgof8AVtjwmO+xoo58NeFdmpyG1JFTtm3OWK2eVwdHtIhiEr
	HF3MQtB6biLCLZyiCOVaqplgq4XVTJtJzGgtjTnOOS6SSeYxd2Rnoc4GqB/oekQ24KL5iwTU12O
	LkROQT6pEpOtx5gCszKkNXdkXQhSbq6h5aw4eVp0D/mvxT/ipelNCU9ubcZxPtQYFUi2Pu2jr1V
	At3jVm8wRO55xm/QKcKqlhsK+mI+f1MFo7st/vO0bZ9qCijlI3bLQeIJ2wf8SzYyyAb4tTVWIVd
	+Wj0dB0AQuaK4J/aw1EMPNmymWCkJycJJG5xCieavuqZSegL/4Q2aFClLeU4IRExaky0CyHmBDS
	2QAwxOt+2u9WV6nFUqxJgrdbeMK/SXgyFWgDBPIE+6boT1rUQChUMYdQA8
X-Received: by 2002:a17:90b:48c9:b0:3b1:21d9:4c3d with SMTP id 98e67ed59e1d1-3b1b0cc8744mr6495500a91.39.1794686209991;
        Sat, 14 Nov 2026 11:56:49 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3b110c0sm4748452a91.3.2026.11.14.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:49 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:45 -0800
From: Chris Down <chris@chrisdown.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>,
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>,
	=?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>,
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 05/13] mm/migrate_device: don't collect a range twice
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-5-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-5-50a2ed382b61@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114115645.be49d8916bb1b419@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Reviewed-by: Chris Down <chris@chrisdown.name>
