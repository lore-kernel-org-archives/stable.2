Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C186340A76;
	Mon,  3 Aug 2026 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737709; cv=none; b=WXYKkaX42DA46zXXWM4J+O3oeU2W0amedbe/GkRVG05Rh13cWxZtDYePaW1/g4uiVd6ObVKmPRQbXXAZmZ9DL5qL77jYOkfznM/BlA/dPt1TOSr++bHgUNYLMOR50XHZaL6DbeJa68mirQiOD94iFXSvhHoPmBQiU0tbOQC+nsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737709; c=relaxed/simple;
	bh=Tb21yfu87NFZBVpS9Ap/HWKpf3xQaoyHjh3UwfkWTp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJByAOFbVCWr91kUdbD/k78OE/83zkiMqAe6i/nRqZsx8S0X594mJs62nnagbCMQUZw3JDMiVv3XwOy9yzDxWZMWJ6SbSc8Kalh+me6CYE6QSxUfPqD3UGSNvZo7b5JKchy8UUPwSLWSHEYuYpoT+3phFhZxUbvnRK64lWy6DVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=U9bUao6K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYGIV0IF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="U9bUao6K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYGIV0IF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D2CAEC00A6;
	Mon,  3 Aug 2026 02:15:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 02:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785737706; x=1785824106; bh=Tb21yfu87N
	FZBVpS9Ap/HWKpf3xQaoyHjh3UwfkWTp4=; b=U9bUao6KuNjE8I04a+8vWPT1HY
	LTl/6XEQns9ce4EtQzIweSHeEdEf3H26oWXotcwgJXDaWdtdMnT963hYXEtL+bt6
	TeI3FaF3WBEPUfsGhACpww7eab7Aqeo49SUGVmhP+ztyeN6x1+q1FsH75VDCTkEy
	hVmX8U2regLPs7z5QTCGRqqeiZL/jvclN04caS+4Yjb2IGTdM8itqVUfXFSkOfno
	Sg0RfwwQzeBxEHfeR+qfdueQQdgQWBgeTgd2RcXYPxbu8ANVX4W4XQB62SbTH7ln
	qz3ZPAQhXTRtC7yKTSN/xgma8vIoC5bfJKb6v+zFH46TmzbYC+tHCAxfoSrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785737706; x=1785824106; bh=Tb21yfu87NFZBVpS9Ap/HWKpf3xQaoyHjh3
	UwfkWTp4=; b=VYGIV0IFxZxSjzZ72gEIRDzd+NvtLLjDmFa91QDZy6563G3wD0W
	sBEQf0nWne4vNOGD8Y5YcSzPVz/y+hDD3DOiajDSYLx0XmfYsMBkGn7qJOFmFZHH
	vtm8wKvUOPYMQj7FlTRRcpC0VTzmVlawEs6+S6/4i84cM+MIOxIn+G9j/ErHd6N9
	SknDgLUiv1Cj5VmYNjp3kFnSKDa8mBXFa700it7zPsehHzRhQAxFHdfvDncaZuLe
	MZhrWuuRvayMXDuLYBPg4fQaCffPYFrCr6SMnA1LbfhpKDnTqcME1SC+cvbU97ge
	uN6F360m+hcyoQPZ8CQxnfDLEfkV/TfEfeA==
X-ME-Sender: <xms:6TFwaicNG8O5uLMwpnPHkmKlO962-qowM6SHcOYegGK3LDAAsr4cbA>
    <xme:6TFwahbryYLhvjJnsURXexvsvngwEVs_ASTXNGjShhi3ymswsSIk1RfzjZvzhnlQa
    HmdusZVlqcylht0m_abO9PqUaHwptiHP4BWVvN8TphBjcYuzQ>
X-ME-Received: <xmr:6TFwam5k4QTv_Z38rs0x4aUmRcXqLGyFJ1NPyZBPvO2kaO9Mzvxh-W9oue23Jhffoc2GR2qmtuOXR6xHwxxi5UespRkAKtv6qpRehYoMDKY>
X-ME-Proxy-Cause: dmFkZTEdxWFx6PHPk4/J0sy8vZcNNRDZ3mcZK5kzim1fg9VQzbIW9Ii3kQ/eSjK1U8QcLy
    nMvMm8DSQveOXCFFG/NkriwpiynWZ7C9rITDAniIEh0+1ZNWsjZMsguHcUQ/7LNvqhbQOl
    xbBbv4B/qsTQ8BB/o27FtveQ16J9S5e63/SZDj25Mw4FZYoGYYDwkcINEKVjN+UNJuCFaY
    NrsJm0Ob0qDae9iIySjTu1V9xzgKaoN263rDphrGdSdGucpiuiXVMsrcmnKYto9R7sCEJ9
    xUidFn/HfFkLt0LyMAVabg8mDlZdkfaMvEAEpGYi0oeTYitVyr9wC+rhU/+Aomr+AskNCh
    kb9uTK1SaO65cVLlYzXzgVn3kr++m2N7zL6a5IMq6GIDqI4yihUHJJqcw6cGNQWVxtqKsB
    z+n9JgWJxFu3YUQlhtjvQN2E5BzVSfaOfh+lfMGEuTJGt67ew6SVz7doBOqBFzSQLKmvc2
    2LYZM74bDtw4AKps8/MKdsKxmRjDhsQUPswfM+T8E4VFkUR4phjBhj/+8kDyXF6arumOWP
    zLfHnGOFxSa2xbSdAX8EIBJYOYgb5x8OOTlteRWpLXKKwST4+mjMH3/Tx6rvQMZoXaMH6y
    7T1PAswharchUPFbf2f6zwkkhIJ1lY2zHmt6GvK05Sgu5KZqDYPKKwQtloyA
X-ME-Proxy: <xmx:6TFwavfVuCuqLNmrczrjZKgVJia3PSr8uZDZdAIeke1PKAzkloYIog>
    <xmx:6TFwapyXHgKc-BecE_co2SOH93PCD1Z9k6NT4qYboZ8OWf29P2Z9Jg>
    <xmx:6TFwalo17a-Pabsp3zcui4VGtM70l0JYiigZFn6M5v28uHZMvY60CA>
    <xmx:6TFwanwkooNi4tCB-nn07N2_le3CquQ__yayJcSDnlbIwq4MYJK8ig>
    <xmx:6jFwamIgPvFMcErnziQvI7C8RbSKEBkvnYXq3ChqG-kLAAF8fpZ-lAZR>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 02:15:05 -0400 (EDT)
Date: Mon, 3 Aug 2026 08:13:36 +0200
From: Greg KH <greg@kroah.com>
To: lurenjia534@outlook.com
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+435fdb053cf98bfa5778@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211_hwsim: drop frames with invalid channel
 width
Message-ID: <2026080324-paralyses-unmanaged-039f@gregkh>
References: <20260802-mac80211-hwsim-invalid-width-v1-1-94d9bba2ae60@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-mac80211-hwsim-invalid-width-v1-1-94d9bba2ae60@outlook.com>

On Sun, Aug 02, 2026 at 08:12:54PM +0800, lurenjia534 via B4 Relay wrote:
> From: lurenjia534 <lurenjia534@outlook.com>

We need a real name please.

thanks,

greg k-h
