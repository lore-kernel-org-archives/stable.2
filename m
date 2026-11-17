Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953968;
	b=uciQ6W5aBALyX8MJNJuddC8MxZDsW3bN2AQBkGnJKGyyM1ynH57AQ70L+U8ZWuWXzpb4
	 vsUF0nL4ZxRuBGG1yZlIdv7iRg0zZwCVqmUUFdDUmLw6cUseOaWK5CkZgvjuuVMPRiJXq
	 +8q8Y+ZxtQ813YtCUU0upu7LiEn2Ze1IqfO/5SncaAm9Sp4rUrUOn4TTQ9YtZIMdqAKX6
	 JTh9Idt8wkl467xtrfgF68sR/mfujFkd6jyHf5EvrmEfVUF0713gXQgKbMKcpUMIobpWG
	 OhD6PwqR4Ro/cCWGt4WKYb3ygpibl0ITdqZsEXSzBtz8P4k9zxDVPX48bwAgnKL8UjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953968;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=rGLjDXSfgCErvBWB/bhwP3/MwrJRJcIxm5tjf67sQQM=;
	b=dQSCB0b+tKQKKAfG0tfg/MpnDNBgqAwrtWWIa5c8fLQpOzXKbCM1KzIFyI11Cx9YgdD/
	 gT9RNlqsOgZVdmfuIqFRVB7Noa+lbDWRcbv8b31CBsQ1gO3N1XGr8myWixE7OgdpLaE2t
	 N/0txH/cpATZAx328NyZGyiFwxQyfqI1n1dkz2dcJGMb+SVI2MQe46Hbo2hDpMJr7z4y1
	 4+DG2rnhp1TOdU2aR85Uixzk+sn9bEcSFA3m1CRzJqKxiJ1AJtLXuOppEC6TahRH79v9i
	 rAxP4otkPezdnMCRKuh95ZBYVYNE9lRhoSv7s/U1bN8eTQyoXriR90DwLVkJqtk0ZxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=J6prgEkp;
	arc=none smtp.remote-ip=185.70.43.96
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88025606A32A;
	Tue, 17 Nov 2026 22:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88025606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=J6prgEkp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794953965; x=1795213165;
	bh=rGLjDXSfgCErvBWB/bhwP3/MwrJRJcIxm5tjf67sQQM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=J6prgEkpFtKJ2oAJnXgmSUpw8K4Q0iHXVlLMs5aI8KvBaz/lmSn0mOH7iD+eQqHsm
	 5M7JGspoPJ0GZ7Tsv3s9sdJZhPuIQvyVicWn+4+sTF3Ebe/YWVYuDH+SX65RKI9qRQ
	 zK8G7k6BHZ1kKg1GV9ZJwdQ50Rs5U54zE/9qTft4lXJsbm+XtaxIGC/vaLSrBtMPhp
	 Rx58Ng9LFvIhDZ4qi1DsgtGCp3wEeRPOnCJw46ij5w8yUwUoTOuyqr49Tj90G5pCFP
	 usQOJzfbqiFV2Vi9muz9mKyBrtOrDZGzp9Hv/wkag030hRwqUkYr1Snht/k1nsMRwo
	 lEKio1oG9S37A==
Date: Tue, 17 Nov 2026 22:19:19 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: pfr_telemetry: keep the state until the last file is closed
Message-ID: <20261117221910.941588-2-ca@modelmiser.com>
In-Reply-To: <CAJZ5v0gQgAAHWwS1ftxaTKHSeq1ADH7-Z6sm77d=_vWBrrkgTA@mail.gmail.com>
References: <20261110144436.1529000-2-ca@modelmiser.com> <CAJZ5v0jTHbr2KD3PXMdcOCs+QUrGrjGGuxOH7cbOe4kEF77d-A@mail.gmail.com> <20261116200935.2464922-2-ca@modelmiser.com> <CAJZ5v0gQgAAHWwS1ftxaTKHSeq1ADH7-Z6sm77d=_vWBrrkgTA@mail.gmail.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: f4aa8982bb8d9e6ce4923b72fbdddd37a483ca4d
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
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Nov 2026, Rafael J. Wysocki wrote:
> I've fixed up the above, thanks for the notice!

Thank you. One leftover from the rebase: 3ecdc4c7d2bd ("ACPI: pfr_update:
wait for running calls in remove()") still refers to its prerequisite by
the old SHA, dacb7cef6f32, which is now 59a1090d0d17 in linux-next. It
appears three times: in the first sentence of the message, in the Cc:
stable line, and in

  Fixes: dacb7cef6f32 ("ACPI: pfr_update: keep the state until the last fil=
e is closed")

Chad

This reply was drafted with an AI assistant (Claude Opus 5.5).

