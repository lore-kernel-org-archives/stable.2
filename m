Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686197;
	b=kNSbcsDta31xdYU7JIC5hBapApLN22YiW7+i/wEbi4v9c3tkXnQobYhAzUQ3V9HH/Jup
	 J4HblVXw+hELvqjuyDsPC3cCiaZLtYXnPsqc9LOAi+WEMCsi6uok02Xsuo8RNVbrYGZgv
	 oVv90FmMtqIwIpCZnN4UwdSSW7F2C9d+ZgO9f3uPVk00tV1XCfbfBeN18+vdoE7OznV8B
	 +/wtEZ1QiJCkBrtqWSvQyP4IitEuNzsoWgix+BQjEjfKbFWnQWC/YbPfwaYb85ZCBPMgb
	 gj32HhSCKRwx3+W/ZWOSTmS2aerZZ/lAc03CQEgjGq5PrTv87qB0kK5dSgUsQLQwLag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=M5xf74SF1IJB+GwjvbT5WVTIN9Qc9W/2f2algOzAsJI=;
	b=u7EFbWRCOxtkqDk97m/wfXOCyGwL5fsXLM6a/Ss2py38YB0+4/1zAKSNMiCZIRf/ZSwT
	 51yViOhO2ZRwn4zIZ0965Xwxh+HMy4fDjJcGuMKI+I6JS8QH5H0aAOWe6to+KlmNQ9Xur
	 l/VhBSUIwAWKQSksnSKhGAN427SViW3nkxxGNP1NT7NVfqlZzM+u9F55FoRVR11y8xG3O
	 sZowlHj1ADj9mwUbw7OQlselO7dpCoJtwVQNsoi+0emUzj+RXeZDeF2M2J84v/F+zrFnA
	 E1C2Xpu1vfrIkjlinoZnbokfMF8R2LHAGyV0Jdo1pmxxXYv/7IlcJ4LhNxBOhKYcE2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=frR51aIF;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FAD606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96FAD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=frR51aIF
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3b0ae89de91so1325648a91.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686196; x=1795290996; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M5xf74SF1IJB+GwjvbT5WVTIN9Qc9W/2f2algOzAsJI=;
        b=frR51aIFf5WRfgU3th6pOYCYM8cPJl+KR4SweyAH1sd2oMQtEvVXeAyd+ik6wWZZbM
         18I62ot4lGvwOuXsbafyedHV4rvfyJBzrm0Yichbk1qGZ77ZtF8h+i9uX5pUWNblKneP
         esVU6y26zfavI874j8xW7a93My6Xj+L45Zcj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686196; x=1795290996;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5xf74SF1IJB+GwjvbT5WVTIN9Qc9W/2f2algOzAsJI=;
        b=JZxK+0SmKLtNx6db+0ZgYt29saLLOwdfsSuy/jd0/Rmc7Ve+upqpUS73EbB/EDhlhw
         uNswlJrt9WN5sosPbp/IUWv1ynOabwUtyxOM61tcl1z7E3OtncmzxKbBAIxQXeiLgT5b
         HBhyi63syfSfh0+BtjQGrAVayYmCKdyVQFoNT1NSDSjGXpSuQswiSVeh6WMkp3dQMWa7
         z+s3AfAnRt05f9GAJvAhiPJI1djQ1gDpYMKUAkqKsuOkvLSqnfRdTwoOBSX4IYGQaJTx
         5KsAkguC4D6uPjs1g2nkglYL6wECAH/Wk/rxn9nfQf1tbHUIRs0SLh86z0B+NxTyt8OY
         4VGw==
X-Forwarded-Encrypted: i=1; AL+hErF9husCvxSDzqSD+ytzZuuL92wWwyUf/SgPLDCfeAJ/ndJghaIR317e4nFYgbaw4FULOhNqIOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8usZoMv+DiAckBMRCpX6WQckCWaIgtRIPvT7QWeek0mAnvm0jU
	tbcQPCeW+VuwEuK6dMoFbZGvZDWYfO+qjOnFTMUNjxQ/BQUt+S1kGpaa1C/KYZWDHbA=
X-Gm-Gg: AYBFou37nLbDJQtDm6B0Eixgl131R99k3UmOWPqk5q4XF507yOafoJL9ige6nttOqxC
	Tz4XaLrdpH7ukL4CjBNReBLoxch9pJ4/mwbXHM9vjVHKJkKi9qG9ujr5ayfYIzDXRiEGxxePZ/2
	2igd6VHB5WXeOJWAOwrdbWD6uoZh0kwPN0I6uUN28YYPZITANdq7/TcscKxAdDhfhuAtWpVh30h
	eexkuPsBxcgRWXbKZHmJZvjRq8+1qmPX7K1yzmjk7F0tKVu5/dksIKcVuusW6HGwhqDMKkA9onI
	uxaQUEr0KOf39h444/cx8dw4nLUS/MPvcPLCMvX2YWMiGxR6AyRv6kyFWr9sHARacmSgnf+JUxM
	occfq9wZj2lINr4ZVHK2ngBxeenzSrh8ukjTLIKrifcz6VupVeFYOG5ji+I4SHI+lYZ5zaGXLAX
	YUbv2vb56X8XhMP189gMFh2sD393sBL1QJk43KHKa4fqk1svo1acE/79sRYNO7Mf2hw3UcMEYse
	u7CS6DpM7JFhV5YPJgK7ZVd2uiazOGCi/CJDFSrOKCMzC220zAdPfa4CW4AUNRdXZCMD1GO7GNV
	TjUgzM84o09YpOwo2QjFV6MTi1bgbqedEi+o4cYybfdBNoa7blJEqrpgXyq+mBs6VZbtBxgpxWz
	ZxZb0c21Dr7R8dmUYrO8Ksx7bqdPaJBrzkMS2z/DmCQKB0jQXzu8OBjRU2sZqMLXf89INF/Bsel
	K0hZl7JQ8zJaXN61ouJyE9dTfAezlfvz6PnODpNkxEM9yJuCXgpZIBfIxGwfDRbAsJw6x4tXUT4
	BtZDA==
X-Received: by 2002:a17:90a:b494:b0:3b1:bdc8:c32b with SMTP id 98e67ed59e1d1-3b1bdc8c4bemr3620403a91.53.1794686195875;
        Sat, 14 Nov 2026 11:56:35 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm14940403a91.16.2026.11.14.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:35 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:30 -0800
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
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-1-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-1-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115630.0b75d0b49869d4fa@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this with memcg OOMs where one kill is enough to get
back under the limit, and with it the second kill is gone.

It's probably worth knowing that for a memcg OOM this also needs my
css_task_iter fix [1], which is in mm-hotfixes-unstable. Without it the
memcg task scan stops seeing the victim once its last thread starts to
exit, so oom_evaluate_task() never gets as far as checking MMF_OOM_SKIP
for it.

The test I used for this has a 48M memcg with a 30M task and a 1M task
in it, and then a third task in there faults in 26M, so one kill should
be enough. Out of 300 rounds of that, I got a second kill in 299 with
neither patch, 277 with only this one, 147 with only that one, and none
with both.

[1] https://lore.kernel.org/r/avA1wXhTMs9eY2NF@chrisdown.name

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
