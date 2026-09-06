Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BFD3D090E
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701615; cv=none; b=jCh1VWAoWQhEI6F2YDbv4JAMRVsKEcMNZeQi6bvDzqP+XNnKC24wupM61S72cj+BC8KqxUQSRi9OtvvU4wNH6xcWpggC8dUdmAmmxd2EEUsYwZJvfu7u7dJQmhJDSXi6UCB/jDU6cDeAxMW88wQBfzqCz1b8RZXIKKNIFYdKqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701615; c=relaxed/simple;
	bh=8U1iwuOUE6NhuRAOrqKbHxcSlOznPgXcVomkrOt9Ewo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgO/NJk0esinyx6wypAdt+jFGy+IExBNVAqVZP/MyQMj3W2kcLmCHbcyn1ayrTprm8UXrpxLn1tALZmFEeuIhHc7oeQ3MbCsXAUIoCm/IF4empejDce2ieyjTg3VAudBTdqF26UKfY+l8AQl9tm4N7mi2pdawp3fWwquVCCCtFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK7x2nUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK7x2nUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC071F00A3F;
	Sun,  6 Sep 2026 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701613;
	bh=Xowze3L+hhtMHBOr5FS9gOZEn8QQZl7sFRrogLthd8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CK7x2nUENXPnu+rJ35Z5y5ls2imFElbrpJ46YDSSmeVqwy69Jn154QGEQBAFhwpfO
	 H6ItBcK8oFtqN2h8Q/1Q65km46FAf1VlssATAW6NiTgqiVTBhza6Tcy4l92cFrwXSC
	 NNXZS3XVKZE+A23e15zDT7+8ko71LwnLNcWcfWtAzblF4aOHUlrwI1FJONnAwx+TDY
	 1KlDUpkw3CX+F89gaK8ICHJ/TQJAUtuKW4zmD2PB3zi0t4ISmrMpY3gu8Y0TdfPetA
	 q8ubzNMlw12+pBFmJ98eWTd9iUYOqAK1Hjff+KJXrgL+CLbSbSPHAyRGybRmVLF4pf
	 LAHV5pJhqun5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 5.15.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Sun,  6 Sep 2026 09:32:39 -0400
Message-ID: <2026-09-05-daily-reply-0009-skb-zerocopy-source-skb-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904090726.1808822-1-i.maximets@ovn.org>
References: <20260904090726.1808822-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> skb_zerocopy() copies frags from @from into @to. On an
> skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
> operation on the source skb the copy helper does not own. That completes
> @from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
> SKBFL_SHARED_FRAG page-ownership marker.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
