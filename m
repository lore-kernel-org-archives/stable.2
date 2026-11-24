Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541611;
	b=E3s/6EKLjDFHRqzeHcl2eZHxGKxHwFFssk3hI0uM9UrIcR5/EhWFInMhwWVh2RXasELV
	 g5Xb+I5/wdb1VxsoPyIeJDkORIOtVjhQDWAnYEb1WTydygTb4zxzM6D7hkNW3N2psmlpT
	 Xfiy2RSc3rJH6qw3o+XPq7RVpt/rr0AFj3zFpYGhdWeah4yrn0Z2Sf6MspAPF8N4aDOR2
	 hUNpyqhEN4UY6jLESr4riizfRd+ITTURxH18enG5fiWV1JR6exqzUMcP+0SU2OEmDYl/A
	 OgCTClbTVB4wUW84ijMMYf5lji3RgQeKFvdg1ZKj+G1kTpog9Q77KRqanrfh/+x1BLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541611;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=blq/el2aPt5UfDt/KiVCvCZ0Fkkm7VLYJBz/or3AGCI=;
	b=cZBe0YdBpNp+JlEKsADugMjXmKCYKfpbXXNflRGchHK+FVeKZdpRqBeYCaAiClLymtF5
	 lBNoDK9C4akWH7B9qT5zzAfX0QUfNf3MKjDdjT5Ncti5QWFZbOM4F1+JOqa3YjYXpPLBy
	 C48a6SRMhWxx5c0CIh0TpYXrxuBwVEAJ5RR2UU1yM/6iecu2TlXBjKp5H80OrFp7l9HsS
	 wpcd8f6KYhsDoZNLk6+XOYGYJ9CDG/llL96Q8bvIwxO/vz3B7GCgoWp2vSis2lixzkEbL
	 1Rlh5AxMNnTwSPtPI2spOZCTqjCJKJz2+bbZFvvm3aGxOi/4KLXEkba/dZCyx0hNrOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=b4UlxNx+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E7606A31E;
	Tue, 24 Nov 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=b4UlxNx+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090C61F000E0;
	Tue, 24 Nov 2026 17:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795541610;
	bh=blq/el2aPt5UfDt/KiVCvCZ0Fkkm7VLYJBz/or3AGCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b4UlxNx+hHhTvQlpuWn5Ve2tZChP3vfavnkVO8u3JGwAdSDvVnEl9QrxbONCENhk3
	 DWYyWCuN5+CAQekwedZhHBjXousbu7eTBul+L2nCB4J8Y16encOJ22C99TIMv0Paca
	 mifcMmZICk8tDWEmGDl+z8GQuiwgDybK5mZ9iTx4=
Date: Tue, 24 Nov 2026 09:33:28 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Puranjay Mohan
 <puranjay12@gmail.com>, Pedro Falcato <pfalcato@suse.de>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, David
 Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, Jann
 Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
Message-Id: <20261124093328.3ba2e066e5d5081c69e0e667@linux-foundation.org>
In-Reply-To: <awXHR007d8MlhJUC@gremlin>
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
	<awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net>
	<CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
	<CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com>
	<awWz3nc_b8x3mIXq@gremlin>
	<CANk7y0gAxY18Ew+6j5YsqrOsf5Dx+v5M78r7_8JLXh5RHZj4qA@mail.gmail.com>
	<CAJuCfpFuDCUPTUi3SuAhmbtw5tubRZ0+YEY3PotjyJ8Or8pdQQ@mail.gmail.com>
	<awXHR007d8MlhJUC@gremlin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 24 Nov 2026 17:23:35 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> On Tue, Nov 24, 2026 at 08:34:40AM -0800, Suren Baghdasaryan wrote:
> > On Tue, Nov 24, 2026 at 8:06 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
> > >
> > > On Tue, Nov 24, 2026 at 9:28 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > > >
> > > > On Tue, Nov 24, 2026 at 07:51:42AM -0800, Suren Baghdasaryan wrote:
> > > > > Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. With
> > > > > that RCU unlocking move you don't need other_mm copy and the comment
> > > > > that comes with it. VMA won't be freed until RCU lock is dropped.
> > > >
> > > > Yeah but they can be reassigned? They won't be _freed_ until a grace period but
> > > > they can go back to the slab and then allocated elsewhere  right?
> > > >
> > >
> > > Yes, they can go back to the slab and become a different VMA.
> >
> > Yeah, you are right about that. So, we either have to keep the RCU
> > unlock in place to keep other_mm comment valid (my personal
> > preference) or update the comment next to other_mm to explain the new
> > reason it is needed. Either way is fine with me.
> 
> I think let's just change the comment?
> 
> Andrew could you change:
> 
> 	 * stable and can be freed in the narrow window after vma->vm_refcnt
> 
> ->
> 
> 	 * stable and can be reused in the narrow window after vma->vm_refcnt
> 	                     ^
> 			     |
> 			     just this freed -> reused :)
> 

np.

--- a/mm/mmap_lock.c~mm-vma-drop-mm-asynchronously-in-vma_start_read-fix
+++ a/mm/mmap_lock.c
@@ -300,7 +300,7 @@ err:
 err_unstable:
 	/*
 	 * If vma got attached to another mm from under us, that mm is not
-	 * stable and can be freed in the narrow window after vma->vm_refcnt
+	 * stable and can be reused in the narrow window after vma->vm_refcnt
 	 * is dropped and before rcuwait_wake_up(mm) is called. Grab it before
 	 * releasing vma->vm_refcnt.
 	 */
_

