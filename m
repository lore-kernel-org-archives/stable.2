Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B407330B01;
	Mon,  3 Aug 2026 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800002; cv=none; b=KEMOIiVbYumywvjDAN0fXxHR8eQYWkkRUtGKYaD/jg8w2/aEXIfxCTgSrJOHJ3rFnvmwuh14UYHxza53+UL5ziYdY6TBOIVoXA5q5dzrJf0Djepe+feNC/IDJswfW8mTPTieOdAGWg2FRuyuBxujc+nJWZpVomlydcQ81FaEsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800002; c=relaxed/simple;
	bh=zveTK7wkSbMXISxQrjVLA+YMAfkD0OlhwITfZEJGXyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXKwGKGDHfeDrYpE7W4O8I74i3vy+FbgydBpjl0qR1Fzn4FY/b7wUyAc4HIBHPxc9y/QFzWP2q9CNFxPoeQB5LDvaEJ1OjmBCxHNbIFhc/akf7CwpiR44FskCiQV7fCS5StR7PCLnmBcW8zntp2jUtxcxe/7hYHJYMqQDvmCNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8NJ+iDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8NJ+iDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916701F000E9;
	Mon,  3 Aug 2026 23:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785800000;
	bh=uQ4lduqTGbaAGqVmz0m6IiMATE54BovOr9IQtRWkjk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A8NJ+iDtMvOGhYSOi1+g0IZHr8Oy/RfbhD8Gg38HFJByHK1yGKs/vfv53cHHzm/eO
	 8ud4Aei8G8A/VJt2c4+dtnVUGmTG2G4nnsiZ+smqUnuK0LhYhOO9QGXwieEe0yrcFY
	 679X987Oy5LOWmXg8JIf4WczHHWasaApyEcOR7zuqgsdKkZyzMoaITrRhm+LuexRNe
	 Ip31rhqrIjTDPGDt9Tny469TIAQzDkVQoDuv3ehwTKzExZ1Hgops74Olo5DMkf9oKh
	 cBAr4soDPoE+mHsDz/NFd88/WX+NXxaMcgXqO+n8Tc9VsJomS/oIV6nQZKZ0YEwoWh
	 UKQvvpRSv7tJQ==
Date: Mon, 3 Aug 2026 23:33:19 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Rochan Avlur <rochan.avlur@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: use the mount idmap for the owner check
 in f2fs_xattr_advise_set()
Message-ID: <anElP9djtLESAgWF@google.com>
References: <20260729041656.51967-1-rochan.avlur@gmail.com>
 <20260730-jargon-tauchen-angehalten-d4e97dde0ebe@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-jargon-tauchen-angehalten-d4e97dde0ebe@brauner>

On 07/30, Christian Brauner via Linux-f2fs-devel wrote:
> Hi Rochan,
> 
> > f2fs_xattr_advise_set() calls inode_owner_or_capable() with
> > &nop_mnt_idmap before allowing the advise xattr to be set, instead of
> > the idmap that was passed into the handler.
> > 
> > Since f2fs supports idmapped mounts, this compares the caller's fsuid
> > against the unmapped on-disk owner rather than the mapped owner; resulting
> > in the actual owner to be wrongly denied with -EPERM. Use the idmap
> > argument that was already passed to the xattr handler instead.
> > 
> > Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
> 
> Seems generally fine to me,
> Acked-by: Christian Brauner (Amutable) <braurg>

Thanks, let me applied Acked-by: to the first submitted patch, which is same.

> 
> -- 
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
