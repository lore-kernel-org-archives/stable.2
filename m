Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989510;
	b=S/P0E33M6OSp6+EEFE6sba89Y1vezO2Myysn6KKNR1baubTETC1SDmCu6xExidBAqEvm
	 QIsmx7UlQdHYIENWT6kV8GpqzqVGEBADkmRUu/0afwT3U47MacZ3Wcb3vJKM1PXXcYHsv
	 Z4Lo4rGHFbp55OMOY/Zzb7UJhNkAGofHS1rFtpKqA7SpSyKobOqyrryPcYVV43NpBYQzK
	 Kt+0ToXwE3JMcxr7XaUznCnG+9VsqC7VX5xsIAu5cxsX1FyK4OkGsewqoCm3V5AFUQ7rq
	 AE0QMXdlKWxodoU85EjfCyjsCMHFyRaHPh7dkrr1QtOJutLKtwPuuZVEZwv0MkZ17CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989510;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5EjjUWVvvrfn4V3bwt3HOQatvRqxR8KPb7agh/PORn4=;
	b=IcSrygL0Zno9zyEnNA4tKIgOOor/6Rbk0bcGfWSgksosWi16x30FjliXqnYrHAeUib9U
	 QbPhc5oILPWT9qtkLTaw5Pn/QqmPwp8h4O1jX9dIf+NlqckCJ8m3jgftbzkzgsJwPzuaa
	 vBM6x8lq4FuBHJNAZkLQyZPTBBD9t5tB98vAWrB9t0siXSetuYCZF/RFx763Sil3IoF80
	 2Yq+X0Tk8Bvu0fEtQdw3iHjwLRhnaH1o8KePskvWT1xCk2naReF0smoHKjwDF00lCsoj4
	 2qyaa6UHSI1G2cL3ptZ9kqZxPAr49IwPcsB6LmTycIphbnPHMedR3A1smlrcFuyYGOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xUD7fWcl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837A606A32C;
	Fri,  6 Nov 2026 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xUD7fWcl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD2A1F008A1;
	Fri,  6 Nov 2026 18:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989509;
	bh=5EjjUWVvvrfn4V3bwt3HOQatvRqxR8KPb7agh/PORn4=;
	h=From:To:Cc:Subject:Date;
	b=xUD7fWclfVq37YFxJOHfhllXW3oRHvSSCsXZwzTX4gV4y9Ykx9D3vzXTx5kDCDPLl
	 bU5njSAAemiyfNXmCJukmFmkxO1vi6aQXe2JEAtrfeN2jWMNF0onOgD3nw1WRhuU8N
	 BhVVXd3aWH3sxtYeQjIvYf2vM7Umppxf+CM3lYrw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.162
Date: Fri,  6 Nov 2026 13:25:06 -0500
Message-ID: <2026110607-squid-outlet-b53a@gregkh>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.162 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                            |    2 +-
 drivers/block/xen-blkback/common.h  |    2 ++
 drivers/block/xen-blkback/xenbus.c  |   31 ++++++++++++++++++++++++-------
 drivers/net/xen-netback/interface.c |    2 --
 drivers/net/xen-netback/xenbus.c    |    3 +++
 5 files changed, 30 insertions(+), 10 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.6.162

Jan Beulich (1):
      xen-netback: defer xenvif_mcast_addr_list_free()

Juergen Gross (2):
      xen-netback: Fix UAF when reading statistics data
      xen-blkback: Avoid UAF when reading I/O statistics

