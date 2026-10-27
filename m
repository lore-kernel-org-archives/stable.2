Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094363;
	b=5gI3KWCapPF9i8H0QJ5tdKXINi5/AkVyIlkbrMiUviX67AFK9MroqoTZPd5Q/Gazx33w
	 2bylbCbmVobICayQr3TSep/j374uc/j/bQYl89AwWOxJglZupC7XBuVw6JzbC2idLH+qT
	 n9SldRtfLUMKDkFMkftyzP3UhcJ80lTDC3mgZ3+R0D5SSGEL+Mweub/vlRFCe63cTrmmZ
	 wi3vqav/rzkGQ8TdljFF26jYnNEZ11jcXZf9RUiU1vyIjtu1A9IOVaFhZMI6ewgyt109n
	 d8EVwUIcEOgEtXswwCocQjPZ3mWMk/PK2OAVTI6osBSbuIVWDVhUPt7aDtBszgZXIYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094363;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+T9dXJtHkajTuMxj33xJNknQApvv9iNPJoMhnaDiDss=;
	b=xOsYouAMU/xruRhwWbAJ4/MVwRtNrK1/rhNJWjSG4zV0kDervRGeiuIO0H9pFROZ77pW
	 G2hfwQIWalNYaT1Y2bElWuhLoMmrttutlHid/STFftcx2hyCTJRHetoYVljzFCAtnMK4m
	 Dag+pIBg4OgAmIdg3UQ8M/r1gC/bLOAwLvOc7RCc/UROy7daykOUaorf+bnyJMSo6hjZd
	 2E0lFoKZubW307oEHiciiG/C7FMUWowDotNeUR23DuauJbh7vRunvx3idRBWPBLaLeijD
	 uNguIQhkmwiIIGFPsc/INgPJuqrOmQ/6L3iCHxmUONAWKt10FoqAQ+MSC+H4MeDEP3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoZqLVAo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B7606A326
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoZqLVAo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3C81F031E7
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793094362;
	bh=+T9dXJtHkajTuMxj33xJNknQApvv9iNPJoMhnaDiDss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RoZqLVAoSWSAEmjBUgu9YU78srb1gwKkbdA8lS4bEtzWIHsPLUJiW2B2E75h9GBjH
	 q66Fr+bjISn9zM6oSv1d64uWVfBv/+RLraP0X/pjl02RwSPrHcdBk3hvtQqxYdwuBc
	 +zEMxmdaTBeJJUtCPTjAxwb+P/eDQ1F4FbYendLcPCdMKu1xX1w6DtspI/0b8kQV/7
	 4y7lTNNgU0gz8paDIJCy/8loVjufVEc/415q6oRf+J19aXUnnCk3siDIYBURTGytRB
	 Ltzmc8Mz+4aWfeVTkMDBHpcjxlVK5xE47kPG/UVvsiPikUMZydmcyo+aDG8nGcblVK
	 hUgqTpADSTHGA==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f2ed2541aso66312285a.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:46:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwir4P8GZyrWtLbp4ROqa9Yfjdh7vgLxE0nCS6lOUh8S5jL2B7S03s3Ras/I+ja2WyhpmYVmxg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLq+IYmXaY9fHkImIIyD8vAhBs7/jSM7nHBd04UAztA5Ggcn2Re
	CL5FphoCyFrIQCeimLKKq5yPveF/PLq5i41/mbWr4R4rMRBQ9TSz7YXqN2KUbicZ4SotmxOlYM0
	q2I2eGnhL/6wkEFsDbRCFydH+afsMVhI=
X-Received: by 2002:a05:620a:1793:b0:93f:1fa0:9f27 with SMTP id
 af79cd13be357-943f4ad5cb9mr379876485a.29.1793094361679; Tue, 27 Oct 2026
 02:46:01 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org> <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Tue, 27 Oct 2026 17:45:49 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xh2BXe_e+8oJS3ZbzoLi=7r7-+90SHPy1+OwcPNdGUxQ@mail.gmail.com>
X-Gm-Features: AclHuK_Q0tGAJYZBBe8Ofc91w4jrj3Ei9mVOmmElYzvOyxGV38djS-jM8bZnzBM
Message-ID: <CAGsJ_4xh2BXe_e+8oJS3ZbzoLi=7r7-+90SHPy1+OwcPNdGUxQ@mail.gmail.com>
Subject: Re: [PATCH 02/46] fork: take mmap_lock before copying mm_struct
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:18=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> dup_mm() copies the parent's mm_struct before dup_mmap() takes the
> mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
> and newer heap mappings, causing later brk() requests to fail.
>
> Other operations (e.g., PR_SET_MM) on the parent's mm_struct can similarl=
y
> cause inconsistencies.
>
> As a simple and robust fix, grab the parent's mmap_lock earlier. This
> way we don't need to update individual mm fields in dup_mmap() and
> keep missing ones. Stop updating the 4 existing members (total_vm, data_v=
m,
> exec_vm, stack_vm), as that is now no longer required.
>
> Keep releasing the parent's mmap_lock in dup_mmap(), before
> userfaultfd completion, to avoid moving the userfaultfd handling into the
> caller. This should get cleaned up later.
>
> Move uprobe_start_dup_mmap() to preserve the lock ordering.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
