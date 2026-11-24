Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535810;
	b=VR7YyNXFW0RyDBc2hgTfO7oHASfDh/DIygWJaemgU2Hgasz0woh20NrwHXp7N7JJ6KJl
	 vx7oxDp2kAjn6Hz/xsNJ17Qr9v4Sy1Wy17yP3XRgVRJ5xHfqzTaKlQMQyUuvmLdDMVmsh
	 sfyAMpqw9UTIZlXzumaNMgyq1CFNvfKlPcGIwLr7DLd9TF7H2/9Pl7xE2S3EJ0CuRdvMc
	 fvTqWNlhZTE5BmVUhfEbFbRUhaTl0VjsAQY0X9/gzjoWYXXwq4F2JKg29rekt0QdHu9Gx
	 jd7SHb+Zpl/SaFeFkF12S24OdFwih/4H0pId07ckUiA0ibeLTNo9WYv8XvtWoDyaw6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535810;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=k6r3s+BqLdhqdRRzKh2nC27WkeQWODtjIQNAEONMLSQ=;
	b=AGBrXrnmZavxnLubaCEFfzK0Q3ge6OQGJLy99xDeAMqC/iNgwC9RLKyZgBN/vo4r8B0M
	 QSEiaw1TQJ1AKauo3im4U3bUDZ3IbTG35P7dMzgs951i5sBkgTihWspUZnPJMJfXzJIxV
	 DapOuAv2hPFOoHeuwtAGJ8oIHxunLgok1jQ+SheFSW6g9ncsg93FxYFU4uE79kKQgf4g8
	 ZgU0owZfue0Q9W0cEUgA8aYscbkGPUu+dr2lCzjOgdGMVqY/9xQw6KyVR2MWG2Vvw4JQZ
	 mymXydeYTeHWgSmPzBnJ0UgjA9sqY1095Ex3Q7xIp4bdxp7SCUKz/m9UXZLsUyOEoww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqGzCa8Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E79F606A31E;
	Tue, 24 Nov 2026 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqGzCa8Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E731F00A19;
	Tue, 24 Nov 2026 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535810;
	bh=k6r3s+BqLdhqdRRzKh2nC27WkeQWODtjIQNAEONMLSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YqGzCa8QL0NVqlP2obsuHAelk4S6MZNKNwnM1WkANuOvgUnuT+eZGV9RJ2XEjkz7K
	 FvRTkrcmhoQQ5uVUVRxayEYsnRH8ekuotj988EOVhVQoYZzNeJ/1Tdg+J1neSGzbDH
	 QrkXsgGaZYCsUr56aGQ4nxmmBr4SV32321hTRXgJDckTPmjRxd7wLfSET3J41QNpEi
	 ke6DXkEgzjAYwwSnG2tS1aFSP1PjJj8/KRFmLzx6Y0d/LstYiVIOX+IUvFeEbby8zm
	 BQaQOOBgsrVv/9cnK1HcPTqe7+/KkPPsaolk3FE5lKQp1YWRGr4/TYN45JZ7wbHDx3
	 3oGNJDxgPn4Gg==
Date: Tue, 24 Nov 2026 15:56:40 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
Message-ID: <awWxsn2c1xR_JiEs@gremlin>
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
 <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net>
 <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>

On Tue, Nov 24, 2026 at 07:46:04AM -0800, Suren Baghdasaryan wrote:
> On Tue, Nov 24, 2026 at 5:04 AM Pedro Falcato <pfalcato@suse.de> wrote:
> > Is there any particular reason for unlocking the RCU comment last? after the mmdrop_async().
>
> Yeah, I think moving the RCU unlocking was unnecessary (unlock as soon
> as possible is in general advisable) and we could just remove the
> comment. Both versions however seem correct to me.

For simplicity. 'The operation is done under an RCU lock' :)

I alluded above, but intent is to revert 0b16f8bed19c which I _think_ is
fine. And at that point it actively simplifies.

The operations done there are only done in a rare scenario (VMA recycled) and
now the extra bits done under RCU there are really quite small so I think fine.

I will follow up on that later.

> > Acked-by: Pedro Falcato <pfalcato@suse.de>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks x2!

>
> >
> > --
> > Pedro

--
Cheers, Lorenzo
