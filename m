Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.160
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330678;
	b=NPDNoARRoFvq+O/OIWdQXWy9bZFb/Fl99jezgmuXGWZ5KS4T4a2TBP1KciJnJ47XJaMT
	 tO+yO/qPQvT2W8cvKmxuwC75+rrMKSNPCLnPb0pAeCI5DosG54kFfPFmyxJcVbPTu9tmC
	 Nkk6uOeQciOSrHQJDQ37oTfT+jwPtGAnrssK5XNE3vZAJuZWmsQdRAs1u22aIQzF5mtes
	 L9SanCdYTjRkkz6Na4l+2Z88CNAQ9adTKfP1ho4jPshZSsQkO0tt4IZMThjZVZ8y+InJm
	 ZTGDabkZcWgGPoTLzyBoMmlHgGaCinxwVdR1EA6tjVLfhbcm8BQ3kocFRJZlj+2Mjhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330678;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YxF7dRKdKAp6T/NOw/hryWAVYb3GZKlSovGXpa5oCY8=;
	b=4kB7fzAAUHzbmuTg/1IIOu1Eccvo1EOHIKDfsQyv4h4h+qET3qbTrVRxznSQMq2WTzAC
	 OtEGSm/EGbCExWrfFhiFjNCLafGtiEcJxi8SvQNTz3ZhOSewlBCCZSbUIsz97+P/125PA
	 EIQ/NNOQobiBXFjTwZgxCeXa6f7TOjkzMXJQDqi5jsZYizatbTHh430NPMtOI+h2Vb+dY
	 h0I2MeIEYx6RmT5MP9TA7JihEMir9HwszEPsW8YWzN0y3rF0eZpwAjbt2GWYtwn4Hde3h
	 Sv5ckjAUIYy740Hky/LKzPB9S0g150UiIlFh0IRpKk0XX4vWlbFMmGaNMZkR6t01W1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sFWn6Osd;
	arc=none smtp.remote-ip=95.215.58.160
Received: from mta1.migadu.com (out-160.mta1.migadu.com [95.215.58.160])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B9606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF7B9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sFWn6Osd
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=K9e2xpCltZ0luCSKJ76+rRB5TbBjqG8Rs7tkxWAziAc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793330674; v=1; x=1793935474;
 b=sFWn6Osd3p26eREcmcIASru+spScdxjMfW23b0Y2POx0A7cPjdRAZnOrHq+XGzSQm8O8znSL
 GcPW+KYbC/rayHgTcZsEHJo0uyjZtTCnQEGFm/LVMX+PMJM2sOtnbK4b1ngvJXY84rWZ79OpEq2
 myhFIaTzDDfiCZo6MKBT4eIY=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 13ff5ce3ac3bfaeb;
	Fri, 30 Oct 2026 03:24:34 +0000
X-Mizu-Trace-ID: 13ff5ce3ac3bfaeb
X-Migadu-Flow: FLOW_OUT
From: xu.xin@linux.dev
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	harry@kernel.org,
	hughd@google.com,
	jack@suse.cz,
	jannh@google.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	josef@toxicpanda.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	kasong@tencent.com,
	kees@kernel.org,
	kexec@lists.infradead.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	muchun.song@linux.dev,
	nico.pache@linux.dev,
	nphamcs@gmail.com,
	npiggin@gmail.com,
	osalvador@suse.de,
	pasha.tatashin@soleen.com,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	pratyush@kernel.org,
	qi.zheng@linux.dev,
	rakie.kim@sk.com,
	riel@surriel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	stable@vger.kernel.org,
	surenb@google.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	weixugc@google.com,
	will@kernel.org,
	willy@infradead.org,
	xu.xin@linux.dev,
	ying.huang@linux.alibaba.com,
	youngjun.park@lge.com,
	yuanchu@google.com,
	ziy@nvidia.com
Subject: [PATCH 38/46] mm/ksm: reset the unstable trees of all nodes
Date: Fri, 30 Oct 2026 11:24:09 +0800
Message-Id: <20261030032409.127393-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> 
> Let's fix it by tracking in ksm_nr_node_ids the actual number of
> allocated tree roots.
> 
> remove_all_stable_nodes() and ksm_check_stable_tree() will now scan
> more tree roots (skipping the empty ones), which is harmless.
> 
> Fixes: ef53d16cded7 ("ksm: allocate roots when needed")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/ksm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index dbfb8f98b1892..9c51925825cbf 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -475,6 +475,7 @@ static void advisor_stop_scan(void)
>  #ifdef CONFIG_NUMA
>  /* Zeroed when merging across nodes is not allowed */
>  static unsigned int ksm_merge_across_nodes = 1;
> +/* Number of allocated stable and unstable tree roots. */
>  static int ksm_nr_node_ids = 1;
>  #else
>  #define ksm_merge_across_nodes	1U
> @@ -3636,14 +3637,13 @@ static ssize_t merge_across_nodes_store(struct kobject *kobj,
>  			else {
>  				root_stable_tree = buf;
>  				root_unstable_tree = buf + nr_node_ids;
> +				ksm_nr_node_ids = nr_node_ids;
>  				/* Stable tree is empty but not the unstable */
>  				root_unstable_tree[0] = one_unstable_tree[0];
>  			}
>  		}
> -		if (!err) {
> +		if (!err)
>  			ksm_merge_across_nodes = knob;
> -			ksm_nr_node_ids = knob ? 1 : nr_node_ids;
> -		}
>  	}
>  	mutex_unlock(&ksm_thread_mutex);
>  
> 
> -- 
> 2.43.0

Looks correct as far as it goes, but I think it is not quite sufficient
on its own.

The documentation requires that merge_across_nodes can only be changed
when there are no KSM shared pages in the system, but
merge_across_nodes_store() does not enforce this at the sysfs level.

Should we also reject writes while ksmd is merging? At minimum:

+	if (ksm_run & KSM_RUN_MERGE)
+		return -EBUSY;

Ideally, we should also check that ksm_pages_shared is zero, since
KSM_RUN_STOP (0) does not guarantee that all pages have been unmerged.

That would make the interface match the documented sequence and close
the remaining race window.
