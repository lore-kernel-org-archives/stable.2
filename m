Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB63D47D9;
	Thu, 30 Jul 2026 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407029; cv=none; b=dn+5Xu6noFnXri3qnHNwhx3UgZQ6hs7hOzrXTIytmhNKdFGV5HrzoSbBhh6w4im3STrbfph/IXrrYNE2BryYM+LiJ5Fh/Wx71up6a3msaCTjiuq/7sAkZA9K83o9r8ZFmJTyvaK2ZxkCql29wtvDmMYN2/Z2Z8G9n0Vj6mjMZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407029; c=relaxed/simple;
	bh=9VBLNDT4VKqFoxo1wXCe9pbICUl3NYjOWY9OtJVLAHY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=H/WJzRWABQqzv4JU+6YFRYZKIfA23OPwxr65EbRmWXw69fpud8szbgj6ijRjIOrlJL3qaWbGlZdWvXM08DtF7U1+PNgdVfq0mtR00mBfPi1TeySaRtw9r99AN47s9SSvrKtwwvIPjUG5fslb3IoXnXsX0JdVxaX4PA/vl31HmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOlAKKWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOlAKKWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428CC1F000E9;
	Thu, 30 Jul 2026 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407027;
	bh=GsbS4Sw15ffaz8qVeqdZl5yarhOra7Ro1zRToupS0NU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=OOlAKKWH5ZLW4C4vRqStaiLEwGPcFmygYug/aHGsoHcnv84pN+zBCWP3wF93rw3vv
	 0PIBoAJo4wAlHH4er7u69Q2owCaDEpzPQ4cWhH6lJ6c6zOknODiyvPwoHmDSll3NrN
	 UWUXY+yi+F//BQz8wBCMl+uLK5DhgCL/1TiA0aJrE8s/Sddo3d0FB/uuMH+IbXnFWN
	 0qCkLTxIQ+oz2tJb06CQwc02ccXJY/jo266ABzN9gwRNJJwcNvu8zgQ9oH89Ioy2z3
	 D5NssKKrsXf+IcF/ysQ67DgWGxrfjvG81CwidTrDH4zZ6k8A2FASFI/h8LD3URJ6nt
	 RwJd7eHy4XaMA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] f2fs: use the mount idmap for the owner check in
 f2fs_xattr_advise_set()
From: Christian Brauner <brauner@kernel.org>
To: Rochan Avlur <rochan.avlur@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260729041656.51967-1-rochan.avlur@gmail.com>
References: <20260729041656.51967-1-rochan.avlur@gmail.com>
Date: Thu, 30 Jul 2026 12:23:42 +0200
Message-Id: <20260730-jargon-tauchen-angehalten-d4e97dde0ebe@brauner>
X-Mailer: b4 0.16-dev-3e0c3
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9VBLNDT4VKqFoxo1wXCe9pbICUl3NYjOWY9OtJVLAHY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlqxmWTf0f/bf7xn3mAxK9+ZxRlgvObqq7ncGgkrjGJ
 KFde/eKjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl0djD8z01hMDV8MvdJyAaT
 /bItp/pY+zItfnWzPY129WJUO8UqwvA/c9GOGadPLetY2OAY45bKXyLgo90lOJHl4fwX9WxLrfa
 zAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hi Rochan,

> f2fs_xattr_advise_set() calls inode_owner_or_capable() with
> &nop_mnt_idmap before allowing the advise xattr to be set, instead of
> the idmap that was passed into the handler.
> 
> Since f2fs supports idmapped mounts, this compares the caller's fsuid
> against the unmapped on-disk owner rather than the mapped owner; resulting
> in the actual owner to be wrongly denied with -EPERM. Use the idmap
> argument that was already passed to the xattr handler instead.
> 
> Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>

Seems generally fine to me,
Acked-by: Christian Brauner (Amutable) <braurg>

-- 

