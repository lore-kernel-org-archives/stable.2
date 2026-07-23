Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF441D655;
	Thu, 23 Jul 2026 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799170; cv=none; b=L82shSpYbhziBBMDNFRLAmHeuZi1x+YdA5WZvXpcUO21zpU0HKVE/sjmTicoMoZgq7bMnh9wrcKmJqAIqOMPAtOTOvrQk2639gxeDAr5Nzr6jkSdKWugQu2S8QnZJYBf32r0oUQ40vg6Rvf81KkhXYGtJ9KVEf4PkrituNIy6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799170; c=relaxed/simple;
	bh=/724x8JHTEsIfLtXA9NsDTfV5whujWjtOuKFWYJmBSI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nks7vfqlXn7zaHABGLVor195YJ+URTpfF0tGLUDTeAcBTLgXGaRDXblG2FjKIiq9ieFhvKmmZbV8rAVoM5MWJH/ECzaPozEVDqx0FtlT4mGgZ2eqWY71nlqm/TtzLQzsKMdClupHoIYfOreeaEAyRjDslaq3DEaXqWHemJpHXhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C9B1F000E9;
	Thu, 23 Jul 2026 09:32:47 +0000 (UTC)
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <2380759.1783956175@warthog.procyon.org.uk>
References: <2380759.1783956175@warthog.procyon.org.uk>
Subject: Re: [PATCH] afs: Fix afs_edit_dir_remove() to get, not find, block
 0
Message-Id: <20260723-pavian-fiskalisch-sauber-2450e0515e5b@brauner>
Date: Thu, 23 Jul 2026 11:32:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/724x8JHTEsIfLtXA9NsDTfV5whujWjtOuKFWYJmBSI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQl3t+3/c68YE8/o2XXhIwKd+s9qNZn8J9+LOpSG6ec9
 rY+zai9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPxucvwz7TCjn+7yZm7+/lj
 ry8+nKr76P8HAz7ZCROjt/ie2138aQkjw7fSVxPX62YtXHtNXpA5LUeYM/tuEKPwhb1a5v9dHVn
 f8wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 13 Jul 2026 16:22:55 +0100, David Howells wrote:
> afs: Fix afs_edit_dir_remove() to get, not find, block 0

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

[1/1] afs: Fix afs_edit_dir_remove() to get, not find, block 0
      https://git.kernel.org/vfs/vfs/c/4fca9568c67d

