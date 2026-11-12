Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492738;
	b=eoIh2x04i80g/EiG+ZNy1pKHaXI3gBkvd2mcLbkDbJdYyUPaPVxswfksL58VepTdFbkn
	 0KpFIffgbB4DkTDlE+o/hhhJmWeUtexobpB17oYTWREGBwJUwLl1NUPeqgrTy8z6OzYqd
	 fl/uWxkxSaCu+8U4DR2TRi0uNnuOodZs4axqbpy/RgOHspkQqGqL/D5OGbL6zNJlnLVEf
	 fXnE/p9joQk3pncZSk20Pn0/Av1l/5XC5ImlGH9L0w5HUFU/Zpqkac6VHEmwlUtqR+E/j
	 3bsWbNcOdR1bzaG9aXqPSFVgmnaM7B2iwOqz0y5FfmeoUdHUf3CsIqrnn0tuUy7SdYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uM02Fg1gjU3NBZSPcxHW5Rd4yGFYmOd1Ea0CS7gM/Ms=;
	b=CX5F+misK94DJ3ZdEsKKjsFhfSYJlwOfPGDGWePt28EluL0y4kc+rfe6qgWE7yRQd1/h
	 ggZd2IlF7kLLQOphojDCMKhME8p/JwA16u1n2zbgXNWJhyTm376HhyA/mndFmDUg3PfJl
	 bxVqjUgHYLYkEil35x2b0My+53jGoiu9Glmaibca8T9Zr6o8bagPxzXoVGJcEWxYrae11
	 zgXVjsZ468dl8T/q9DkKlibVmXQky9kh+zeR1/As3eKel98/nT9ti4d7824iHn+gitMjJ
	 2CPb59k7YjN0upNNnEgzJCMyNgaSx6ck+1j6c1ZgkyC3ynFMG2cnU/Y1VVWYlhFoQXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gAM4oD6u;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145D606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 14:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C145D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gAM4oD6u
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso30210495e9.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794492736; x=1795097536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uM02Fg1gjU3NBZSPcxHW5Rd4yGFYmOd1Ea0CS7gM/Ms=;
        b=gAM4oD6uTHicKnz9f6XcRMaEiose74RSU+22HtrUNTVYwp1z4E+0jsTVXhaopMJhuT
         pjs4A65NOnqmzswNjZyNhEselwzTsfg+DahHBo3oXTJoc0kQ/aoomF0w/MnekRyv/0cV
         CCxrtZxViKMXI3LNnyKnDxqhPmzivgpxsBCnS8d2L74xih/EW5CodlRtaM23ZtLqYkXv
         m/OAVrSVnx/aSsd3jAruqfNVGYJvlp8Un5NBSNi4cFxU0OV6uxzoDBD8L5S66G7WMZob
         8Gfo1jphMoQx20P3Qs6ZvBIsuaBUWw7P099WzOZENsx5TTGTQt3eXcWPUOrCWT/0c/pO
         p2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492736; x=1795097536;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uM02Fg1gjU3NBZSPcxHW5Rd4yGFYmOd1Ea0CS7gM/Ms=;
        b=jqWNB9NkgoJabBnULolRuRy49SmaERWr9WT8k3B1CGtpUxJk+t+wJI+g2k47lFeG34
         v19utAda/7JRcgvIkCY39hp/6hNd0JQAFKmNRg2/bBhR0T5KKToPuuQ22Jx00EuEVjTq
         f6aV5MO5diRqX4aT83skmMrR3lPHInJcIqwy6fBBg4wheOtirGqkwpaZMMTXTIjZvupt
         42o0n74zxMSVoNDEKuuxz+DR4Mdfzd/Kr/o29sB3H5DRKcFN5UC2P2c9CZVaaOkCo0qT
         3LJ8Kv67LeuCNy0YIR+gQNMSTfAxpZyoQK3mpQeYFjCp9WIfU9/aQJzI+b0B1iJ87b62
         /Xkg==
X-Forwarded-Encrypted: i=1; AL+hErHwTS3nNtMetPKHpQ6Luh48Ht0BLB+RImuWYbxH1FKL7GDnHFRNyuuSkwRBa/RS48NM8JC3OVc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0U7AH8S0mrdi8vMqprf4Uuv12l6LSCvXahCcrlwMU9vriU5wP
	n9PBBbTcogY5qn5Gadw3rlqeUFk27FRciCspkr1J6aVPD2wq8TuDo7DhvFdaab5q6cU=
X-Gm-Gg: AYBFou1y3GCZ+NMAcVWWLKFtzn/TSOe5CvSD/DkuQ+Qo8GgJ00kMUXPmfBYF+mxm0ph
	cdThoVs0Wv6RERBfmjm0u1Y/TzzVMSdg96Sg8imrFkrSp7vj1ozs/cI1vXMdhEeOp4NBKUjQmL1
	8sWHZHlbR6yIIzxgyLuEzjmfYb2oIDrWhwTUuKMpZcQ2PpJmERwnIcFJp8jCVAExqt4bxAmV8yD
	FzBcL4HjiVPhqW4H7FfpEcct+GSCGHUFFkHPgFa1Huqa7FrFTs/dEKUfAsUCpEQT7QY57RO+xa9
	X6wWknYu4HyCXTm2EDtRxnxYLWL7WA+w5UQIB6zjCAet3o+WwXKtXSFg9oaHKiCqe3Mgf0NwWaV
	Vt7eNFh6yK9CsB8oPiy92/XOstrhJos0AexRWOwssx1C6JTo+v3b0D7xwJezewnFlvb2vNfb/kD
	POAGfGedziEm48XnngrQ6jvL95ChG53lsh6Z38TXNO/GZ1iOZ+XYNOak0gWh40WCWgZTASdrtrQ
	D4BFnVbyo3cxSgiBkgIkOZ57OeBMER0gnEap30BCVnhQlhgJRQ+LGnA535MSemIfDeK6OWD2T0/
	Ij6rqiG7yzQK90f2H53ToteBueuJZYSWYio4KDdQaXA+
X-Received: by 2002:a05:600c:8b31:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4ba0938e3aamr97570525e9.23.1794492736131;
        Thu, 12 Nov 2026 06:12:16 -0800 (PST)
Received: from localhost (109-81-94-245.rct.o2.cz. [109.81.94.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2776casm105702275e9.14.2026.11.12.06.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:12:15 -0800 (PST)
Date: Thu, 12 Nov 2026 15:12:15 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>,
	Balbir Singh <balbirs@nvidia.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>,
	Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avXJPw17fWvLtCO8@tiehlicka>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <avWmfXu39vtp0DM9@tiehlicka>
 <avWsG-zmuniUFio7@gremlin>
 <avW1s2wvz1PB0-Ln@tiehlicka>
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
In-Reply-To: <avW1s2wvz1PB0-Ln@tiehlicka>

On Thu 12-11-26 13:48:53, Michal Hocko wrote:
> > This only matters for the OOM victim, hence reinstating MMF_OOM_VICTIM, which
> > made the patch _way_ smaller than the one proposed :)
> 
> Should we simply do that flushing unconditionally before setting MMF_OOM_VICTIM
> then?

Sorry, I was caught in calls and didn't get much time to think about
this.  I have only now found some time to look into that and to do the
above we would need to make tlb_batch_list_free visible and conditional.
Which is a bit of undertaking, not anything major but still kind of
ugly. So your solution seems better in the end.

Please clarify the changelog wording to be really about this and with
that
Acked-by: Michal Hocko <mnhocko@suse.com

Thanks!
-- 
Michal Hocko
SUSE Labs
