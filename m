Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015165;
	b=wGBBRnzO7P1kLtq043iayQ0Tt7azjI2rnCryEIkxqnJRXIGc1ePGHfEZaywvjanMxuzy
	 O7xeTviRvlFCTQbLb4D5v2QnQIdZMGQWssFXRuMCfi/Ri9zqPCXDfzakM/EMyAi313gp1
	 IuQvmbaOAOg2RrIKPXtsu/CoyK/HXHy52KxlXTWN/PF3Orzs2tdY0sFq+f31ymqawO4//
	 yBnYKSpZO6nXn0sJ5RYeJFgsrNfl0qP+A1fuxGlh8Du8PLmP7cMevh4loURMttm/QP74s
	 sueAQQu9cQEkrWZ6m+tFFeTo3mfAlFccXm3QCPGtZUBOndrDl/mf5qFZlINDoav37tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015165;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=cdHtGmitS+DpnzgyF7He7frabP8q7Ig2PWPVGAcUb5g=;
	b=HlA47+G4TrhWUm4m3Y6OXJpEFQbNuQ6RnkmJnDJI/lv9ahAX8Wm9ZCJDSvel2u72JcqG
	 Qai3kID+hbfXwJuFkeXMnHGmJIJk8DosmRn7QSldPEnvW1ha3Q8eF+3wFAgIavJdX0IZ3
	 C/p3VFuw5SxhaXgmoMF6pawUGMruvUpabN28wrhLNFzPuvtNrUeqvUJwN5hgszGowoo2n
	 O+0wbzXJNPbxanUzkJzyUa+g11VP4vJ8JROvB7gf6IC1F0TrG7xF/bqpue73iT2E6o7Oi
	 hAG4kIzieavU0A44RNFatz/+PPTax0zNucQKVqZtWFYf2fwk6lJ2KPAK4eUnyUxwrCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=QlMj379z;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=uSS0FpsI;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B4606A320
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 141B4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=QlMj379z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=uSS0FpsI
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A3B9EC0A1D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:46:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 07:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793015164;
	 x=1793101564; bh=cdHtGmitS+DpnzgyF7He7frabP8q7Ig2PWPVGAcUb5g=; b=
	QlMj379zqQ6Gvm5zgcyXxsQZv4BkLX+B2Jey2fytuu6NEeaOOjV1G0/eYKG/EUyN
	9AmA0faV+YbnPRCpqFWZS075lPgO2Zrs+J2xMBn5CweKGY7FV7q0G+eleK510l6F
	tAWwYWrlwn+CK09BlBCxivhK2QjH+93LVUioOX3zF8t2SPbojdV0H6F7HJfVPKJP
	CQnAJlWgHPVVhZ/aK6QDFofS5vEyFZmko274pzLhUKNmrIC9AJD1AY9fYM3AjM5S
	coHakQKI6lIIwQkwDr3byKje8Toy8z0GrlgNzR7n/7sCZfEN2C+jSuBDGeaf6+kP
	RMygVVZBkF8pCm1k2g5mHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793015164; x=
	1793101564; bh=cdHtGmitS+DpnzgyF7He7frabP8q7Ig2PWPVGAcUb5g=; b=u
	SS0FpsIAJSU7ZZb+KziNquNVEPNmuLBkdvmcUEhtQUUtmgvvyNI+kyxriIVvfXym
	owOrWOzfvbwLXp0oxy3WLgIuw9yUN7hFnsMRNBoTyMgrW0aNmXbxspiRpqG6jRqQ
	f91VjzjSlNFN73haofAtjG3FI+B4VqF2ZBEMSftwAPCTabqWQ6r85of9E5BCpkgF
	YUFNfD7CwHhCTqFiXSmlb31RyRWsmw7wUxUuNN6F7ppv3c5HCBMyZSKi3dF1vaJK
	5gce+jbMC91RKN0C40m8B376sTVzoP5dbYmzH6YyyNysk3WBhR+YEl1eacqYjY8H
	9Z5GknsJahDaYKWdUTHLg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793015164; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZV8RFJHKdts3uVzLLHGGGyAz3l/WCc71bFNUQBlXTajQI83
	MHkn+YMz3QZNbv9ceHhFfCn0N3SxCh43pJoSEUNtRLOrRvCbzFp2WNSlwLA7GPUU
	JmtqKLzaen1LGsTO1hM9sOxDXTCqeWcA/6IvWwQVY7VeIEjxTPFo/G/5cFKjUcFB
	PHawa3J9sMlJ7CVV7kmLb8TaO3kqT1YB3LeHzQjgPhPM3Hu8K3Rrwl/JbZY+9+zr
	2aQT+05M6e5bg8x9Zvp1zv7TiYuExOMMGXL8cGeEoPmYYM6hk4JhxFCvntRj/3uK
	1dkKroIOzoZn+IlMvjFTfK2fuPqaayJqSURGbsg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lv6/d4gtCptFuLHPSCTAiMsohXFUNt3uk+EzD/tQTPA=:cdHtGmitS+DpnzgyF7He7frabP8q7Ig2PWPVGAcUb5g=;
X-ME-Sender: <xms:ez3favU5qRnaQa0V8hfiRskkmbNoTMgkK7rZPDAVO5IVbTjA4MqjfA>
    <xme:ez3faj9L3BvS5zi4Tt71B2fCDJcFxYPOK5EJ0AqFVpXbu5t_jLZXbglCV4LnHCJ_W
    iJpz6MBspOixIilGJo1yw54vOi8T0-19uPFb0JpAGnOgJT4yVE>
X-ME-Received: <xmr:ez3fav00NgumAgSilf0ZptjVhZ7tqfaE6dV-CFWPWYjogY1iFxYNX07Vz1YHiC4Yps-HvpIi3fNQezBRmaHcpSARxary46_LDhXJRFdoIPU>
X-ME-Proxy-Cause: dmFkZTGlr3vRP2HiOL8+7Mped2TXdqbzMLCd1048OLauO2/4u17MywByvK6CW7xsQkYtf8
    QTgz82V085Rw96avnGOJlpvOm+oa4HIXXpl9zwWqKMzTKMdUOMTJVykPwdotRMPhK2BY/0
    Pbxuo6EARpL4It2vfnso+8qq1k8TLnp0+6xKa5hUV8AAQemWzMbpJDTJivzHKgUf0+kPty
    wgKz84JaZwL5gFGaTjZrq2YEiklnczfuDewNWn6ZuKW3T6dyUyVTqj2sCe5mV712aA/3O4
    x6O2aOgMjf0lnXOTmW3pDP8eazOgi6FBfDTqOPsicPvgigUh1ezjaHowMlxL2ip3xdoeLq
    H9mEGkyW8YOuhfg1RdCtfF6laMTex94IrLU6IQohEdhY2QRKyEtBWDz1jl3O+TpPUdtxY/
    ryklWUsWneuG3JNpdKHZsxHWMfmzvLlWEH+y5zdYPnj9BBDTr+y4TPjDgE2KbksTtqZeta
    gR74/SZnBd13xJj6k5udxbFYVRYSn6M3ZSlxjG+Fnmx5W0IYjtWAB2UVTQNUg4J0mmUqPj
    S7jCblBo2d0siPdIZz0JE1MBNL12bkzLBNw8lgh+SqmsszGHLUGau7zDnzttZKhWvwfc6m
    3lmQOKSdNgo7HPAYUefRq/x/oqOGYsqc7Ks38SgtdT/1nj59vmZfgFSWbQ5A
X-ME-Proxy: <xmx:ez3faofyIEBHaHxj-K5-IdiuuZz0-MjFtY4CMZg_5R7h11Tq9IRb_A>
    <xmx:ez3famAtJzvuV06uayHVLUMnHekOv-8mpIewEIieddyoFgNeUUDKtg>
    <xmx:ez3fav-1WZKFQqytwihWI5rwXE59jYcTy_OcFw1B6mIigUo3xwBNyg>
    <xmx:ez3faqqc9GaBYJl7FjQ6og8-vHvTDte2nRegroJPR77NPftmCZqxWQ>
    <xmx:fD3fajANlwS_F2dIVZXj1kFERamrKXzvoLfoG1kRgIDe0Eb1g3KT18xf>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:46:03 -0400 (EDT)
Date: Mon, 26 Oct 2026 12:46:03 +0100
From: Greg KH <greg@kroah.com>
To: =?utf-8?B?5bmz5LmL?= <treebacker@foxmail.com>
Cc: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ahern <dsahern@kernel.org>,
	stable <stable@vger.kernel.org>, security <security@kernel.org>
Subject: Re: ipv6: skb_over_panic in __ip6_append_data() when mtu -
 fragheaderlen is in [1,7] (single sendmsg, since 2.6.12)
Message-ID: <2026102604-circus-juvenile-c521@gregkh>
References: <tencent_B58BAE2F5FF485D1B4F652E9980EAB132A09@qq.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_B58BAE2F5FF485D1B4F652E9980EAB132A09@qq.com>

On Mon, Oct 26, 2026 at 06:54:50PM +0800, 平之 wrote:
> 5. Suggested fix
> ----------------

<snip>

can you turn this into a real patch that can be applied so that you can
get proper credit for resolving this?

thanks,

greg k-h
