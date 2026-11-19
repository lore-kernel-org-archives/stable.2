Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091853;
	b=wkHuwPucy+/0stvU4ShD47BwO9/SR7OC5+EdOkzGl0jHz13W9dzPfyNJ788cUVyAWi1N
	 YjQPK5ONzmRJq4ma2G+IoeLfLU5oT4op0pacWVJGBMAngxJtaEIZ1yBaDGv1taM4aKq03
	 CPnFKKAMYda8/lQ87CmRYdxBuhcZxrZZ53z0LPaYI1TZaGTgOpTkHgp1zBY5ziWS7XV4r
	 DPKM9nIX8G59GDRW65p/HwxQa/d8K21xHjCEqzD3YElkRwpwCDxAALI1Cj/09puAeGgMt
	 aDfL8ohc9/DMtdrxDq8jzcyWH/ImHzAJAbekbe/Wk7+ufhJqSwX8ohVhyEisc5kyJRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091853;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=kqCXGYamJRKiHQlhg/8k0daaNHVNYy7+R0aPc9YaCxY=;
	b=jfHGOlsD0F1P4+auvfIObOeXkG7G0Fgbb7DjavP5Y/QvR/UWMFyDPtexNb0CUN03jTC6
	 7NZ0sri6RXNpP1NPfsp/5VKvn20YiPjmvxhLP654EbVxC13ZT+gwbmqcxz163sm1GvL7z
	 abaNUXnfNHDBOWERgvUBtkE4UpLImRqUzccrNmSeENQlgqkcCPzjgNrgSfe0kNgHW1FeA
	 lgSn7dfL9WUQmhlfSv8FtxqKYqSnEgnKb9OU/yV5ED1RYkhnMODCf66GcgjsI3u9d/hRi
	 /PWzAgKaWh4tOy5CKg2PogyD97zOgUXgKdE/VPfkINNUpbcCBe9m049uTroPzGO18fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="RD/HH5/s";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218EE60A2615
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 218EE60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RD/HH5/s
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E4C6B1A1712;
	Thu, 19 Nov 2026 12:37:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B347960237;
	Thu, 19 Nov 2026 12:37:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A79B11BC0775;
	Thu, 19 Nov 2026 13:37:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795091850; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kqCXGYamJRKiHQlhg/8k0daaNHVNYy7+R0aPc9YaCxY=;
	b=RD/HH5/sduVkUDo0o1rfU8oviKShOK56+EKIBM0lFkdcfchX7OgZRKYweMwx2g0D9QUsru
	STlTJhP88prM6SMfm4NjlxY779l+ABCqzIqWwf4lujw4PsNofAw2OlSb42x7V7ZujsopfX
	pgC4OhZtzLxhQCaFdcDTp7uwZ5VO2q4tjDctpECpPoUlhaaE6VKzGbvdDU95qr9B5+2Kk0
	Q5kxp2KzTKAtPf+zY+6YasNOeD+QePhSGG4MOz8CO/c890FPXgqfn2Uz5XvoUyFMQw6EuA
	VzhffCNeTi/aKxqqjb0jWjBN5Xr76jdFgLYwbjVoaiTYPuyATMDi3kzbpS1IAw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261119-spinand-set-req-type-in-bbm-functions-v2-1-4dc4f995dfad@gmail.com>
References: <20261119-spinand-set-req-type-in-bbm-functions-v2-1-4dc4f995dfad@gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: set request type explicitly in
 spinand_{is,mark}bad() functions
Message-Id: <179509184936.2889394.15959850517165099833.b4-ty@bootlin.com>
Date: Thu, 19 Nov 2026 13:37:29 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 19 Nov 2026 08:57:42 +0100, Gabor Juhos wrote:
> Commit 701981cab016 ("mtd: nand: Add a NAND page I/O request type")
> added a 'type' member to the 'nand_page_io_req' structure and updated
> the request iterators to utilize that, but the spinand_{is,mark}bad()
> functions were not updated by the commit. However in both of these
> functions the new member is implicitly inititalized to zero which
> corresponds to NAND_PAGE_READ. This is correct for the spinand_isbad()
> function since that uses a read request to get the bad block marker
> bytes, but the spinand_markbad() function does a write request so it
> should set the request type to NAND_PAGE_WRITE.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: spinand: set request type explicitly in spinand_{is,mark}bad() functions
      commit: eb0ee7a30f3d33c49b8f60b707dd27cb046cdebf

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

