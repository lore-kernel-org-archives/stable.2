Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA32222A9;
	Sat, 13 Jun 2026 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310045; cv=none; b=MsnzWZ0CwAjPMszTty81m6Cwbl+y0jlhtILs4Bou/wdUzRzWMuXCK2VYSg8mRyO3gB8+NhHBOLNsnrhfs0M6UXZJfho1544nrnRUgHxhqVxmRoV4OPatN/bucxcP31y/snNPU9ajQvLHNn2eOEVtaqS5IbnAon5EmBnELyp1a/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310045; c=relaxed/simple;
	bh=hTUnNkRTucEdpjT2VSKjWvjF67ZPz1PePNE8kadCzz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIEyxelnzlkZ1dgyC9h1tP9+82GXtMhhPYOAwlAJeWo1N3c2IpFUSZdFe5KPvcrG3u2XQ6Fe9f1P5OS2iuiTaOe4+P90scy+g3DTD4sZ0vS7MW1t3igvmF20i5LAJqclj6l/SJiKyDFHJUAtTaOq460vNyF9lj6Sc3HLs4tuje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJJu+55x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJJu+55x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0F51F00AC4;
	Sat, 13 Jun 2026 00:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781310039;
	bh=hTUnNkRTucEdpjT2VSKjWvjF67ZPz1PePNE8kadCzz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NJJu+55xdeU4dJPqC0L/dIX90ZmMunk4WeVdZy9+N0Fv1wm0MrNRUF/tX6Bj5TR1E
	 n5SSYib7Vq8FtxedtyFJDGASzM421ovjoBfA0aOpmXD6tdwJ6CjqR1QCqbmOM5/Qmx
	 Bg3KG6Bsoqdx4lDqtN4a71pYp4RmgWdQcJIhLKD/Uo1owmFUpa/qAt7Tu3rTT/ipJb
	 F+VBzMBQHPiMqkfKlCoe64Sq4NBQfM3yFDztJBebErT/ZXFjrojcdGntM5+4WZIRHu
	 PK4uay7sw7aVdn9DrRKewJO6pBGW0U+cZS3ZSjheT9PHhFw9B41U5Cs+8gp6MHbBO2
	 GQRyOjFSy3dhA==
From: Sasha Levin <sashal@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Sasha Levin <sashal@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>,
	stable@vger.kernel.org,
	xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lvc-project@linuxtesting.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
Date: Fri, 12 Jun 2026 20:20:34 -0400
Message-ID: <20260612233110.2-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250322143418.216654-1-pchelkin@ispras.ru> <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jun 11, 2026 at 02:39:03PM -0400, Hamza Mahfooz wrote:
> Any idea what happened to this series? It resolves an issue that I've
> hit in a production environment FWIW.
>
> Series is:
>
> Tested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Thanks for the nudge, and thanks Fedor for putting the backport together.

We generally don't take XFS backports without a maintainer signing off on them,
so right now we're waiting for one to do so :)

--
Thanks,
Sasha
