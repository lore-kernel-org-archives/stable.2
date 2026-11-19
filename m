Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106646;
	b=CyXnicHL1vMK9S8j1Dxr0GH5+cT1uXuF7cS87EijmcHEAsvZOhJWf1ouCaJfiLTe6l12
	 UiN7KqbU3d4OHG504Hap+HIduSZLnGw6ybla62gXa2Q6ZvUM+6VjLqDT3+NcUXlkDRf3Y
	 XgFy2n9zGFsEMpHp0qE9Batw+J3uL0FhZNvI2rKW7ljGhBcBuWrGYFuZ1Ag1dqf9pYJI/
	 AyYAKPUn+6XFO6spkJBaEYwCfo4WofWmSCEj3swfm2skYCV0FxorG+QJoGDpmQNEvPNqT
	 SVm/GuU6tLcvNX1XHuxeyJ7vCzw+EmZh5Chd4nosk0dSW8LQp3riYimoY/yf+5yuMvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106646;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=7xWoQbusH/Y8VjnnYyYVr0K3Xy3KNrjFcQdKBH99Yds=;
	b=EkyQFb1BucSJHFfdBI4qn0iFALhfzYi263TI1dkL4P5gxxCPenVkisqU0PXx+uMtfV5h
	 LFki8qJBl6l6o+EP6SOaktVv7/grzi3fcr1tjW5smTIv/bRR0lt0NnU/9rNQvPiGzMJz4
	 3w7yj3wKBgZ3ddzVjbKdj+mxrSqQGcauf0VvCxyLW9umStDNlGu3CZaiGOUWh2RHa+m6H
	 wH9x9CKHrkF8aWChWU4aX37+CFCPjeaiUs1Gn9ZID0OWHUl+Qe5+Da/Xn/L1ciLCgrpzg
	 g0gpYHSj4S+6DFzpEiGCj5nE19Biuy+dQX9HQ8ECGy9Zf35qHAffLIN117kTTQzyh2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsW9leLb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDF606A334;
	Thu, 19 Nov 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsW9leLb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF201F000C5;
	Thu, 19 Nov 2026 16:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106646;
	bh=7xWoQbusH/Y8VjnnYyYVr0K3Xy3KNrjFcQdKBH99Yds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QsW9leLbkV8LZAS329LVHxGUpItBJP0N7LvKGT4sjgKn3hsERkmCmqmPw2ygtdiml
	 Vc4Zh14sCdqnThkaeyA6qe0pTyCvSFYZHewnhMSet6OgR22sXW5ijY97aPVibyrTGH
	 +I2w4gZvpicpV8n3LOer+JiUaVzXiD+dozmZ82l9rsO9LYyjkDIxAKHOGB8EQBkUqI
	 vb3rM7mym9bgs8DxkV07ZblLMnflwn99V4cv/BFl+DcKgLD01AyspKKwZP+ceaqHtN
	 Ubqx8ZlAoZhptgjBc9LFE0zC3liRqK1fUsV0LgzYBGD4qq6PluFntuDfd3r5/5o8/h
	 eXWTEfFDXLi3A==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Alexei Starovoitov <ast@kernel.org>, Song Liu <songliubraving@fb.com>, 
 Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, Sashiko <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261119-mm_failed_fork-v1-1-b3019f43d197@kernel.org>
References: <20261119-mm_failed_fork-v1-1-b3019f43d197@kernel.org>
Subject: Re: [PATCH] fork: clear p->mm when copy_process() fails
Message-Id: <179510663721.2987.3052403624854778254.b4-ty@b4>
Date: Thu, 19 Nov 2026 17:43:57 +0100
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
X-Mailer: b4 0.16.0

On Thu, 19 Nov 2026 09:04:58 +0100, David Hildenbrand (Arm) wrote:
> When copy_process() fails after copy_mm(), the error path drops the mm
> reference but leaves p->mm set. Perf and BPF can still reach the
> task, and take a reference on the already freed mm through get_task_mm()
> or bpf_find_vma(), resulting in a use-after-free:
> 
>     copy_process()               PERF_EVENT_IOC_SET_FILTER
>     ==============               =========================
>     perf_event_init_task(p)
>     copy_mm(p)
>     a later step fails
>     mmput(p->mm)
>       /* frees the mm */
>                                  perf_event_addr_filters_apply()
>                                    get_task_mm(p)
>                                      /* use-after-free */
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: for-next-fixes

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] fork: clear p->mm when copy_process() fails
      https://git.kernel.org/mm/core/c/c9b8c9bd

-- 
Cheers,

David

