Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F83B42EB
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861365; cv=none; b=T92QF7M1d3UHok7JRhLvoDSNhYm05bzXt9aiszEU4o4aWYSYKXi0JUBWRtL9Dkcohg0AQIS4ZlHcsOqatanbu12cHkIBzkGVZ6I6KojTxgEM8hzlzclJeSgXJQQxYEf+4h222DjOHQP371KL/SntvtjBEf5yK5qArhV2VAyWbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861365; c=relaxed/simple;
	bh=qhzcIOoY2hosLyVIxdPxsmyEewTnK1YjZA3gz2txs9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnjhEOK6oqAz0Ai5s1fg/rgMj9T2HgHKp6IoHQ5VsCSser6fCL7V0nu8RdCNy/r0RhSZAOTzqbIRNYxbd8UphN4NEJ/wbViAOe6PpkyZP77oHUq9aPHPSUIa0LJwoWuDwIUcD5KTG+MHYz3jEnzusYW/TkIzZnHZ9u/oa5IDmNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RvhAHV0S; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RvhAHV0S"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso59720335e9.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790861362; x=1791466162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=djo86y34WOc5FBXQPseI8JTPk4toU7ySXcp+GeD54N4=;
        b=RvhAHV0S2K/1fncgugK9c9V6+RABQEyMM9IfFhlztnc05JOL1bhrTEOzp8dwA//dgx
         /kfCXemv7nNkNo5fIQCLLMfwAg3Tf3MYF4IXuXxiumFaL45Kk7So5jJFVAH12SjMYhKJ
         vVNs4YRQMh/czuLcXOslI/aa9NAjxx6C0Ik3w+evd3BAFo0AjTI7CkRxp7vnA/stbVyF
         nb/KVPfq2UrKBOLNWaKyHx0eTLA2zOQM2BvuulkQmIB8ubJOZaEOlgZ8tTpd2kotm0vb
         1dTqGjz4hHP2tTLDglDhS/YS43JCKBVs1DOzbpq6JzCsuZCFkVowatwkPu5O3zvPEaPU
         aiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790861362; x=1791466162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=djo86y34WOc5FBXQPseI8JTPk4toU7ySXcp+GeD54N4=;
        b=CbNSzIG158gB0we1nGASPuD8EI8B38oD+xQd7vq7fkQj/+PVvFjRafKklS5s3B5Q3i
         2nIpLen2ggjLKsyKAtsWmJWo42qgzOjHvliafM/+ygESOjsUIWyilA05IFfM8AzTC0WP
         ZuG8/9U8OlutH3Qy/2wvy6iQHB+ViuFAJCu5thOggsatIAbBUJHwBLxm32amFKeAGBxl
         6eX0Y5D1yRVoIl1EKnmBsk2PDkN2eoxjQ4TOGYFYaqck3xsP1bQMYgwLWT6kdao7oMJ1
         CQySGFP5GOpLpts+0LUqgnosFZzQaFt8hjVPRUDYOiS3wAdEjcC/62+8BbTZiLcZcaCY
         PuNg==
X-Forwarded-Encrypted: i=1; AKwUvBwXnOdxv/uFyYnmnudyWtjPxVDH4EG46PpE4GmLRth5eXZCE9oj7DLDhR6oet6sjuukrm9pQzA=@vger.kernel.org
X-Gm-Message-State: AFuF++kUkp+fIjHXLkln9OhbZxSI8XsiYbC0SVI+WTsM0dEueeilmFf2
	bEiiru5GEGHsWP5dngNPXdtpiIA4UGHDKMyHgTyn9Ty/duY6+ynZ0Wk1/1c6UcZRLZ4=
X-Gm-Gg: AYBFou1LbCKaQQrinZ4RsuEwSai0CTt6XXniyKH+pIMuBE4YPZ+LebpX5EbejzQG1du
	6joexbWysLATrTSv+lZmEyvppkgzgbG2x56jCxiOJjwA0QcfhEX6dUOjS+Nmz0GzwLC5azpWs8z
	eFB9jVq0ceHjkK5YC11m4L0XCsBUrmnG9RAXvz0pKl58XqLyx0vu3StiW7BgsRNjViGfez0lxc6
	wmvIWkke8v6PQ5msfPq8c1sMcdYAC2J4NCX2/LrtYWhOATfxRoRpizrVFK+dljMhwGVGLxxHf1x
	YRnImbEmAnBFiHmo1jYC+O+5NetFzCu3BlGDscD7oWSt4hc1YIvAVmufwLIVLU+cEqk/6byJkGB
	SeJl1jA8S/hkjiyVPJSigZsxD5c/rD81xL4XqyJgWcYLnm+FzLCbtA2FEqr1zpFvfuSK0rob2Sb
	tWG3BqMUDVeSthZDqE+DleGjd5mQ454T17RugP54OV7/W6dNLGkb+50e2GUegfLIQqnyFPbIcMz
	feIULq1Gmt7i51XImCP/vI8fYmm
X-Received: by 2002:a05:600c:3486:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-4a01ad9847amr74558815e9.1.1790861361167;
        Thu, 01 Oct 2026 06:29:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.thefacebook.com ([2620:10d:c092:500::6:7dd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a024a85409sm25779795e9.15.2026.10.01.06.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:29:20 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: david@kernel.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	jannh@google.com,
	pfalcato@suse.de,
	hannes@cmpxchg.org,
	shy828301@gmail.com,
	osalvador@suse.de,
	raghavendra.kt@amd.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 4/7] sched/numa: separate VMA placement from scan continuation
Date: Thu,  1 Oct 2026 09:29:13 -0400
Message-ID: <20261001132913.486570-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e1728faa-5d50-48af-8ba0-5098be9124eb@kernel.org>
References: <20260930112206.205083-5-gourry@gourry.net> <e1728faa-5d50-48af-8ba0-5098be9124eb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 12:44:50PM +0200, David Hildenbrand (Arm) wrote:=0D
> On 9/30/26 13:22, Gregory Price wrote:=0D
> > -static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struc=
t *vma)=0D
> > +static bool vma_needs_placement_scan(struct mm_struct *mm,=0D
> > +             struct vm_area_struct *vma)=0D
> =0D
> mm can be had from vma->vm_mm, so likely sufficient to only pass the vma?=
=0D
> =0D
> Apart from that this looks much clearer to me=0D
> =0D
=0D
ack. agreed.=0D
=0D
If nothing else comes up on v4, could you please fold the fixlet below?=0D
Otherwise i can spin a v4.=0D
=0D
should be conflict-free with a git am -3=0D
=0D
~Gregory=0D
=0D
--- >8 ---=0D
=0D
Subject: sched/numa: drop mm argument from vma_needs_placement_scan()=0D
=0D
The mm can be had from vma->vm_mm.=0D
---=0D
 kernel/sched/fair.c | 6 +++---=0D
 1 file changed, 3 insertions(+), 3 deletions(-)=0D
=0D
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c=0D
index 3b30786ded3b..095289d3da3c 100644=0D
--- a/kernel/sched/fair.c=0D
+++ b/kernel/sched/fair.c=0D
@@ -4082,9 +4082,9 @@ static void reset_ptenuma_scan(struct task_struct *p)=
=0D
 	p->mm->numa_scan_offset =3D 0;=0D
 }=0D
 =0D
-static bool vma_needs_placement_scan(struct mm_struct *mm,=0D
-		struct vm_area_struct *vma)=0D
+static bool vma_needs_placement_scan(struct vm_area_struct *vma)=0D
 {=0D
+	struct mm_struct *mm =3D vma->vm_mm;=0D
 	unsigned long pids;=0D
 	/*=0D
 	 * Allow unconditional access first two times, so that all the (pages)=0D
@@ -4313,7 +4313,7 @@ static void task_numa_work(struct callback_head *work=
)=0D
 		 * VMA candidate exists. If a scan is already in-progress, finish it,=0D
 		 * but track continuation separately from starting a new one.=0D
 		 */=0D
-		placement_due =3D vma_needs_placement_scan(mm, vma);=0D
+		placement_due =3D vma_needs_placement_scan(vma);=0D
 		scan_started =3D mm->numa_scan_offset > vma->vm_start;=0D
 		pid_scan_allowed =3D vma_pids_forced || placement_due;=0D
 =0D
