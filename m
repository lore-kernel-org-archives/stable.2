Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9053B5F48
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162652; cv=none; b=CiFAB1oC4wZIHqm/jTYzMdfWGLcF6xL42HDh4gZazigkHe3Y9B4JLxPhF9HGYg84QJWWPCmDs+SFWmbdqA1zorHc/UPoBnSsTZ7vIw60kmL3ZUR4x49p4UQ5wouEOM3yd+BiJYN3eRmqQLjdEo4scw6kniln6zInRrK598I0LZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162652; c=relaxed/simple;
	bh=0hvMDX5dGPzleb29l/9Tm3oC4w1pSlAh9xjq/jWar8g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZvMR/szaWwsOL9E10FhkYl5tmokux8/1vVsstDVqnEsaoEVEXtQjwQgsid/GiUW9fCV+0mzhigrAskYBqjCD5uKu+z1ZvlWveSTfGcvLi5yXfMb07pJkAzwsCI1wEjIy8Jj6d4FKSdoUpTojg9oXzvio4F+jnKj1Th5T64FNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OJGuyAIl; arc=none smtp.client-ip=79.135.106.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OJGuyAIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788162637; x=1788421837;
	bh=0hvMDX5dGPzleb29l/9Tm3oC4w1pSlAh9xjq/jWar8g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OJGuyAIlm47ajtgc+fiTXn3M9eB5MDnZqa9gcy/79odwXVhWSRYAY016+89QTb7jo
	 FD9kEhZw8hj+bKKWobLRc1PahLnAfmg8HDaT0W1D3ND4ib8cpYOec5L+sDeHYh06U2
	 OLkDhaO0xLZJBNrJ3++ofuxw+TTns/Dk3QkUu77HhNhD1r+/wQqL3VLm+0+5zHNFAY
	 Ky9wsC0IcoGt9k0WbIWI8aOwnSWyQRRGRtrLi0Kzkey2b0YbOHCslyjb7DKBvqUOW9
	 1xBLrJWMhuN06oPUvbmW60cHEQ74wuxjz2oMeJ/6YBDhX/TrTuRBmGs5Q6ylguO0s2
	 KMf9rSO6K3lbA==
Date: Mon, 31 Aug 2026 07:50:30 +0000
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
From: nirbhayykumarr@proton.me
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "w@1wt.eu" <w@1wt.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v4] misc: mei: fix race condition between client teardown and read completion
Message-ID: <TLwVYumErA8o-vTKsGdBjrbPEwbhWftX85vbrJl7YR3mf-q9PeneLVl-HY8-LDuCpuoM1Vak9d9-ysDfF5swgpRVb13ihncKDppjylpGV8E=@proton.me>
In-Reply-To: <CY5PR11MB63661742670108288F61A179EDAA2@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <ftGV8Hp-LYTtUVnxctTg6RSMnglJf1Dkgx65y7bRorozRtAeBBPU3zTQNG8Bmj-wNjNl0hTO5m2hyGMw8TktWQ2bijbJzdmGsRmlv-XLk3A=@proton.me> <CY5PR11MB63661742670108288F61A179EDAA2@CY5PR11MB6366.namprd11.prod.outlook.com>
Feedback-ID: 172828574:user:proton
X-Pm-Message-ID: 10a0624fba3dbc07244430a451236c979a49d54b
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, August 30th, 2026 at 2:06 PM, Usyskin, Alexander <alexander.usys=
kin@intel.com> wrote:
>=20
> This change look like no-op in this flow as you moved mei_cl_flush_queues=
() inside the mei_cl_unlink(),
> but mei_cl_unlink() is called here straight after mei_cl_flush_queues() w=
ithout releasing device_lock.
>=20
> Seems like the failure is real but analysis and patch is wrong.
> I suppose there is another path that call mei_cl_unlink() without proper =
queue cleanup.
>=20

Hi Sasha,

You were right. Moving mei_cl_flush_queues() into mei_cl_unlink()=20
was a no-op because the lock is held across both calls.

Your comment prompted me to look deeper, and I realized the issue=20
wasn't the call location, but that mei_cl_flush_queues() itself was=20
fundamentally broken. Specifically, mei_cl_free_pending() was using=20
list_first_entry_or_null() and only freeing a maximum of one callback=20
per flush leaving any other queued read callbacks stranded on the list=20
to trigger the WARN_ON.

I will send a v5 patch to the list which corrects this by properly=20
iterating through the pending queues and allowing per-file descriptor=20
filtering during teardown.

Thanks for the review and guidance.

Best regards,
Nirbhay Kumar
