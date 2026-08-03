Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F963033DA;
	Mon,  3 Aug 2026 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748647; cv=none; b=t0BJVxtDdraEmRkRcKFriblgcjOCdFEXou+o53p4aTTUlRsoyGmC8HtulDpbN447zTTpGjetvoGpQTAreVfNpcx9BfbNt0LT+2Jdvh8FqqzaI2K5ct/8RJSfxhxolXmhnJIGUFnlYxBHjw63E7/9nDAvLviXMlYkkiZ9hOZ03FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748647; c=relaxed/simple;
	bh=PpT4/+lkSih0cmIBI76xlCQG3Tg/8Hh0rM5bUSwHlAo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m6PZg6fHimo9LODO1ctDSSLdIuL0cfnx8YAVUhgDArj/rp4WcTFvChNtN6VRsfhCqo2b1C7OtJ749Z/bwip67k5le7imdwegsQwbbWWFq0O5E5YjDi4B40n1wymIcxwKhqQYOLF3t+bxNLJMqqo/Bvo+MsiVk5yJl9MQ87DdDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BGzo6FW2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TtoFpmRI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BGzo6FW2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TtoFpmRI"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 5829FEC0128;
	Mon,  3 Aug 2026 05:17:23 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 03 Aug 2026 05:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785748642;
	 x=1785835042; bh=PpT4/+lkSih0cmIBI76xlCQG3Tg/8Hh0rM5bUSwHlAo=; b=
	BGzo6FW2nZoG20Cyuul/WnzFGIIOUhHTSjtYc/v3HlcjFsKFu6NsWK139Jh9lM4W
	1l0SJZKXe2BwNLQQtyD1C9I17T+Spz+3T2JFyiSm3RFVluu7/HhL8e5/s0mTA9rI
	23W94C4WZVWm79Ds7DCoYqY0CM+Mbj6+3am4GpkWdyzdnGk+CaDGbxO1Bq1PZNsp
	Hz1D8lPySINu6Bsz5MhL+tbiE03q9XLTIiqyvNBQAgusLHtqZrXyLbSs8zl8taYT
	ztrP+vYz5SV2lHLJ0cvPBfiWlpP1Al3wDsBKioPUACpyXmbGn5nrpWzVdOg7i1nC
	UYV9dSSmwvcu33SZc0bNjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785748642; x=
	1785835042; bh=PpT4/+lkSih0cmIBI76xlCQG3Tg/8Hh0rM5bUSwHlAo=; b=T
	toFpmRIXrvAh1IyffJ5VbixInRDLvCZ5EPBGJwHLDk0VGfr/rmDUQltcSlYhF8Ww
	KvaFIAnTZZ/SRrg4t8NQQxX69K1JoxUe0dZ+t318kqt1m1gjPXDrxygJiyuuqWUJ
	yU0RxFZmyZ+AbPs57WU0I10uNgUO0SSv/s+Uaf1i0wMrY1FVHFHCuMF3qskOw858
	L6onwq0xuGOct521vuK80q/0ks3hgEc8B2/UfJj1JfWv/MU1IDkWXaQy7y/W3v7v
	XkpBLNwc5H98jCII3sod8jA8DqX4AQ/LMJXHp15uRzYL0sITltlg8mh3w1e/u4zO
	QtmtYjzooJKE4wd+k+mag==
X-ME-Sender: <xms:nFxwaqxNVf7HCsCK__ap-cM25s9bginmXRX0vk14oC3X8VoGVfKBOw>
    <xme:nFxwahFuOYwXND9-pEEdMlHu48aHXdqibURNiUSHg6pxydVhbc9WycU65m4FK-w-y
    UOditwe9fy85ihGehKSnijmSmjBQ31kEHN4GEU-X79osKyGotgc8nSf>
X-ME-Proxy-Cause: dmFkZTFsH44K5cCuDLWEkNGZe5kuvAJ1Sz9emqzA4FVerOc2Q+vppEAmxdXmWBrjoFv1Ag
    jzH67xHtqBqpwcxCqbYQVQz74TfgznSEE9QtsvDo76GD0qU3GP8eACufF1wF10Y/WTqpCO
    sDPgw7xisUw7A/QlbcFWo4izuNn+/rGd02wrbX+C4Pe9WxqpPiEk5UGY1/IT9vzldCW+eo
    0at/FSEuGXA8Pk7Pb1IuhbPzJF7H9d2MpjJbxXMSQpMVZG96CSksWLV8aZVaMyYMQrhPx2
    jYLV8VOOiBtxXlFM7qWnPHzYgqm187Ehe7cLPWzaGv32GSOc4cCDSVKNePdch6b/2uFCNT
    I/6kwVdI4VGhuVADgzYVR+HGhPtd1L6Z2zHStJA/Mntg5TjvlvhmB+hEEV/Soe7sm+lA1H
    apsFTPFyp3RF4o/NwRdZEe3u06kK+hJIUyAFPz/BZK1lkM2K9TmtXoV4tDoxLvuEiDdYS9
    HRdlfgWt+adDRYT7odisdlIW04RiZLJXDRlgaTAgApHWh2Pz0JAfCGKMKiIK5W7CAmnXvz
    PGIy7z62+NIVd7t0FEscA2kawHqb7xoNmUFX2UFq4KkUDuo7xCzBV+6A3PkprR5lQaV05A
    DKs18u0K+KsJBzGiQIfAAHWNWBQxplzzPTsH9SdlwarJrG4U9Apcax54Lzfg
X-ME-Proxy: <xmx:n1xwamD7grx1Z9cwnF_2KyOnhaySsUlF_TWGyazKfp2VVuLQL7vrRA>
    <xmx:n1xwanDnilO5Syp6O22c8hlAq_pymOTANBgwiYYkgEyHVQfA9n16jA>
    <xmx:n1xwank1PXIGJ4Zoban4gYt5CmYGNe598gRECEMioqXfCZAssJ-YSw>
    <xmx:n1xwanjGUOkQwN1VrszFy3m9LVmLIkJdzgkYPMFnCww82pZYIMdFWw>
    <xmx:olxwamsxuqV2U51ptjCeehVOKlMIXnLr7tHPXCbI_gLqBJ96kBbS8FR6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9072F32A0060; Mon,  3 Aug 2026 05:17:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArlZzNPIfswN
Date: Mon, 03 Aug 2026 11:16:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: moonafterrain@outlook.com, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Paul Mackerras" <paulus@ozlabs.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Yuhao Jiang" <danisjiang@gmail.com>, stable@vger.kernel.org
Message-Id: <9ff071ad-1f14-4160-8e1e-cc3b48c677f1@app.fastmail.com>
In-Reply-To: <20260802-fixes-v1-4-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
 <20260802-fixes-v1-4-7368423440f4@outlook.com>
Subject: Re: [PATCH 4/6] powerpc/spufs: check permissions in spufs_setattr()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Aug 2, 2026, at 17:51, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
>
> spufs_setattr() applies the caller's attributes with setattr_copy() but
> never calls setattr_prepare(). notify_change() leaves that to the
> filesystem: it runs only may_setattr(), while inode_owner_or_capable()
> and the CAP_CHOWN test live inside setattr_prepare(). setattr_copy()
> performs no checking of its own.
>
> The handler is installed for every regular spufs file, so mode and
> ownership of another user's context files can be changed without the
> usual authorization.
>
> Call setattr_prepare() before setattr_copy(). The existing ATTR_SIZE
> test stays ahead of it so that resizing a spufs file keeps returning
> -EINVAL. &nop_mnt_idmap matches the adjacent setattr_copy() call.
>
> Fixes: 67207b9664a8 ("[PATCH] spufs: The SPU file system, base")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
