Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684941;
	b=yX/JbeJVP9FLBGWwCIbhOwRQUDF9XiI64XzZFrMn0DffDMlTfft11lRmkOYQ3M/OHhXV
	 MvCRmwUNHgsxfy/KNOoOcrdAtTOyx5MRUdpMwWzAbIV9F/hISj+zNtK7U7EjCCbR4LR8o
	 kFTQopEqf3D4CObu26lbv9/cAZMEDbKmtrTbQsZM0p4OS4RPxsPnLvuA5Zw92MEitN0u2
	 58Ht1dW/xTnbJ1XXQ2rBG+boPN/u/6BDK3zO3fMO8SLAGInVrdY90/Uwln8dI1HgYRBtL
	 xnKmgeL+xx1d38qXAaU2CLMBMWn8rSB0KbRAJkivoXuvht/39EhZvMdCeb8ePC3rbxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684941;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f9NuElDwmx9JKzBH+xtXilAFMLSLkvMpGnhqiyMaCkE=;
	b=Q+83W+9YgnVzpJ9M94Pn3MHTv4ejZktqn6dto4fjc8nnz0jBZwVgnG7lpP/OFMNzZnWC
	 bXAbroG5Ifo7hwHVBH7aSp9ceAWSuvaCf+k07E91w/Y/W8dH4dEgr/BsyJ++yxG5R0Osu
	 SiyvoevAVvy6uZ/s3z1qq6Ty/iVnz432P2xi920AUHbADYZLXxpGk71Gv7pRmjL62wQ8U
	 qYMWAvm56F2yJcUetFclR8HSeLKiTbZKO9EbV5W6kgiQysJuq3iCm3OGsnVCxmENU/6at
	 AJqgoddyTIc5WLkOl3L1kuHZNF31h09ZAR6Bq/uDc8B1VXHTjzxHoUYGOkdNa2F+6pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUwelAap;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B8606A31E;
	Thu, 26 Nov 2026 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUwelAap
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785BC1F000C0;
	Thu, 26 Nov 2026 09:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795684940;
	bh=f9NuElDwmx9JKzBH+xtXilAFMLSLkvMpGnhqiyMaCkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UUwelAap3lS3Bvdnj9h0Qtbpx8sIJc00DcdbYb4TcBr1Ymzp0wFoeXKcYyCZ/K7af
	 QEapR5Bdj+9HKP+NimN/goz+/EdUA2WO3VMuz6OKgHycexEPT7ITVxLLWW5feSm4jc
	 HLdrI3SLTELdvHViFvbaIgi1kWFj/YAaM4DOSH4HXfAbzDr96emSYfaZ+Wva7Memwp
	 qtFCWL3yfmS8pR4qY0zqI69JLx+/kZTWfVpMpyhnspBiPR75EyrCQ8kOBAKmpuEEu3
	 XdRSjEPIZT2sdn7YT86n2I0gEydYkTyjkb2B8pRU8SMl9RZJJgsFpFmILJc28cfGxx
	 oJSxPglwibcPA==
Date: Thu, 26 Nov 2026 10:22:14 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Mani Tofigh <mt4022@columbia.edu>, Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory_hotplug: don't offline a hwpoisoned page
 still in the page cache
Message-ID: <awf6RghUETgb41pr@localhost.localdomain>
References: <20261105-memhp-hwpoison-pagecache-v2-1-029d35634d42@columbia.edu>
 <d4812513-6cfb-4865-8636-b83dd92c23a0@kernel.org>
 <2e11ba52-b5c6-463e-a5ea-c165ba935704@columbia.edu>
 <89037847-8875-4d8b-a8f3-d77a59aaddea@kernel.org>
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
In-Reply-To: <89037847-8875-4d8b-a8f3-d77a59aaddea@kernel.org>

On Mon, Nov 23, 2026 at 08:45:37PM +0100, David Hildenbrand (Arm) wrote:
> We'll have to find a way to make that reliable. Everything else is just hacking
> around it.
> 
> Why can we block concurrent offlining through get_online_mems/put_online_mems?
> But I hate these functions.
> 
> Or alternatively (better?), have a memory notifier that block concurrent
> memory_failure() by grabbing the mf_mutex when MEM_GOING_OFFLINE and releasing
> it when MEM_CANCEL_OFFLINE/MEM_OFFLINE.

I think this is the way to go.
memory-failure is a shaky operation and over the years we have seen how challenging
was to interact with other parts of the kernel without crashing.

IMHO, we can try to be clever and try to workaround those issues
(memhotplug vs memfailure) or just make the two exclusive.

@Miaohe: Thoughts?

-- 
Oscar Salvador
SUSE Labs
