Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97044605B;
	Fri,  2 Oct 2026 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977763; cv=none; b=QsrAogwoJPCNDv9RdGTw0+lKOEpkYs/1ufUjAIDSuSYP554qi1ywsNJhY58O2nuWmtVPXGRH4w4v9b7OjaAjX3829Yg0ifWIzabIMvIOBIfU1Bg7VddoZct86lEZrHJSZXnVepxUrn6hheYaQScnz2IrwNBtlcSVuLtR6yss7Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977763; c=relaxed/simple;
	bh=BG3Nld4ztJdypc8LZ843cilgweII55GvAIzMdgcGHgw=;
	h=From:Date:Message-ID:MIME-Version:Content-Type:To:Cc:Subject; b=TKQZgTk63la+D3+OaFCErbXMu+sBnjPjCdxrjHLqUUmL/JCjSsBsgh2t8j+nKRXM547ylYpN7S9SHQMgQP9BFVTjLgU7CXYOWneFNwLDvOAF7fLwu/HczOsTL1RixbatTLRRJnSg5WYReGYGYm2MhT6cNghHBagoS6Ax4UMeoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=q63gFUDf; arc=none smtp.client-ip=77.75.76.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="q63gFUDf"
Received: from email.seznam.cz
	by smtpc-mxb-cd564bb46-95fjz
	(smtpc-mxb-cd564bb46-95fjz [2a02:598:96:8a00::1200:520])
	id 3581030d83bbae14300e1945;
	Fri, 02 Oct 2026 23:49:13 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1790977753;
	bh=vUKfugxund9IRMF/M3r1ILJXYCkNOUo5FBoe5bxfh9Q=;
	h=From:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Subject;
	b=q63gFUDfACgSfK31PdGag/DPLddT9HR45akY+OtFGlHpsH8T8h4ro/gCFpO5/TLeO
	 x9O/c7YUbj6DZgBVYUb/AfppopTqxY+UZrghXeKr7Wol15yLNJD5aV74LUFg5drEP5
	 dvJ8J/VvyRygn9wJLHELe+u6QRG/UbIjQwueUuBFLKksoRsN5AnjqBZgByn9GT39dz
	 v3xhOjJD8YllushPvsuuHOUhzhYPQ9okV8o5OEIMC2e7Rz4Am5TFw3yWV2PshYzYoA
	 MT/23kG/2usEQ1Q5C1odfxy11cjIAQCQ5Pjha8txxopnopmdf/m06A/QjICqYGAf1o
	 tqg3up00fLSBQ==
Received: from [192.168.31.62] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-7b9b5646b-rjdsf (szn-email-smtpd/2.0.87) with ESMTPA
	id 9a49a7d1-01e6-4437-99b3-7b80def0a6d4;
	Fri, 02 Oct 2026 23:45:46 +0200
From: Radek Podgorny <radek@podgorny.cz>
Date: Fri, 02 Oct 2026 23:45:45 +0200
Message-ID: <179097754519.501890.1801734138080126989@podgorny.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
    Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
    stable@vger.kernel.org,
    Sasha Levin <sashal@kernel.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: 7.2.y took the on-air address fix without its companion

Hi Luiz, Marcel,

7.2.8 picked up, via AUTOSEL,

  a552b4bc058b Bluetooth: put the peer's on-air address on air when we
               cannot resolve        (mainline 4914c4998961)

but not the patch that was sent and merged immediately before it:

  14b015afb556 Bluetooth: forget a peer's RPA once it advertises its
               identity address      (bluetooth-next only)

They went out as a two-patch series because the second one depends on
the first, and the commit message now in 7.2.8 says so itself:

  Without that, a peer that turns privacy off would be dialled on the
  address it abandoned rather than the one it is answering on.

That is the situation in 7.2.y now, and it is a regression against
7.2.6:

 - hci_connect_le() substitutes the cached irk->rpa for the identity
   address whenever the IRK has one.
 - __hci_conn_add() in 7.2.8 keeps that RPA when LL Privacy resolution
   is off or the peer is not in the resolving list, which is the change
   a552b4bc058b makes.
 - Nothing in 7.2.8 ever clears irk->rpa. The only writes to it install
   a newer RPA, in hci_find_irk_by_rpa() and hci_add_irk().

So a bonded peer that stops using RPAs and advertises its identity
address is dialled forever on an address it no longer answers on. In
7.2.6 __hci_conn_add() converted the address unconditionally, so the
same peer was dialled on its identity and the connection succeeded.

14b015afb556 is the invalidation that closes this: it clears irk->rpa
in process_adv_report() once the peer is seen advertising its identity
address. Nine added lines in one file.

Could it go to mainline as a fix during the 7.3 cycle rather than
waiting for the 7.4 merge window? Once it is upstream it reaches 7.2.y
by the normal route. I deliberately left a Fixes: tag off it when it
was posted, so as not to invite a backport while __hci_conn_add() was
still masking the stale address -- that reasoning does not hold any
more now that a552b4bc058b is in a released stable kernel. I am glad to
repost it with Cc: stable@vger.kernel.org if you would rather have it
that way.

For the stable team: if holding it is not workable, reverting
a552b4bc058b from 7.2.y restores the 7.2.6 behaviour, at the cost of
re-exposing the bug that patch fixes. Only 7.2.y is affected; 6.18.54,
6.12.111 and 6.6.157 carry neither patch.

Both have been running together here since September. 7.2.8 is the
first kernel I have seen with only the second half.

Thanks,
Radek Podgorny
