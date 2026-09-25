Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623893BD635;
	Fri, 25 Sep 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350250; cv=none; b=FH0Bw2LR+SEd6iTeG2ToaWbOpdCbH/Y4xZPLwapiTQVVN7Rq/aJBkhg1Vr5SzYe1IJrFABdAFOw5Q9NqSi5cQetRFv1mXscW+8WXCrgaAd7owt20U7V+iLXMOUNGLxZBWZaCmfRIUBlFtmtada78KMhhstj4iLTLZlzBUU+fleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350250; c=relaxed/simple;
	bh=dY/RqwsLlvaqaqIVDLHTNvPGIdn2+AbvEIcmdODh7WQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OEIgOLRk4PIEFig/B0qsC8TXO8Ht1HGokC7+SKv6I831aj5bmtQCsJ/A+0UvNm6rLU+5LkS3o9AYA9cquC5vqL1Qbu9UZs/8wPxeJW3YTKrSmdz4u28CS98nBlMI2xZSp7Hn59LEfDSzx/gzTtGkx9kXTkp0RUWLwWGHfJ1lq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocKGoS7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocKGoS7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382B91F000FF;
	Fri, 25 Sep 2026 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790350249;
	bh=CR/C+cs2zl5Jt3ClpZFmEiihTiP2YZT1I9/49Mhx+qY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ocKGoS7N+MWhkj7FfSY5L+lMrSHb/K3Dj/KT/kMDgP8edyH/RZFFyMCQPI8SyU81d
	 zysagF130aWIY2lRIa6ESs5WEAFnKMY6TRp3ejHTEfXyjqWoZxUvKsKsXba6IsZCdd
	 4gWNFRJis4RNv5mY40KCiRK4DYtaLCMyiLgyaRAwbxheJM6bkVAiSHU4rTIGUaAqz5
	 /JoeUxW6oiS15vhUBpFlYYY6kdaHaEZJAdBZ/53iF7pKSgBZyGubc3rJ8+5iGfymc5
	 AR420lNZaiFRqHNnoMlfj+AaX+BSWoRj5yf2SnBUidcaIS6JdRlsL12pLaDmycq9EL
	 9gTjCXYQlhl6Q==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Erhard Furtner <erhard_f@mailbox.org>, stable@vger.kernel.org
In-Reply-To: <20260923063759.34667-1-hao.ge@linux.dev>
References: <20260923063759.34667-1-hao.ge@linux.dev>
Subject: Re: [PATCH v2] netfs: Fix missing alloc tagging of direct mempool
 allocations
Message-Id: <20260925-murrt-kolibri-skeptiker-f6aed7d7a0ae@brauner>
Date: Fri, 25 Sep 2026 17:30:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dY/RqwsLlvaqaqIVDLHTNvPGIdn2+AbvEIcmdODh7WQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtm7y4WeNQcEONvYaLTtbNKCFp54SO4N+/7+mwMUmHl
 kjad3J3lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATORKKiPDQtPLsv9C9F7adosb
 LdgYr3o1+Yd69EFPjsCz4pxfpc9tYvgfpFl3uVS4RqDgUSMXf7d/h+I25YCvfz9wyq75IffvcRo
 PAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 23 Sep 2026 14:37:59 +0800, Hao Ge wrote:
> netfs: Fix missing alloc tagging of direct mempool allocations

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] netfs: Fix missing alloc tagging of direct mempool allocations
      https://git.kernel.org/vfs/vfs/c/b78b728e21c3

