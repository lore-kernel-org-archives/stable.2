Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971251;
	b=g+36D+PIxcCwbc9qvr0K58tgRpxg9jWeit8ipFJNTXNOAGkiQpdIUwgIvvSReSXWPI3g
	 KtctyLKRn/urm3grke1J1NJQluIWdrrIkYJ8qulHVNXzigbJ7ARKI5Vih5VvcSot/3djz
	 mB2Y07tbw7qCtjZdBbnDwbTqCK0HUrWyo5sDOMn8ltt5gB1HbYj64tqXrX4pGft/9Aczc
	 BpNu+SMwD60sOTATgBey2/bljT1f35t+N9sA/kvi6cxsR+Ls4mEGrK8VvS/3AK50/xG/w
	 8dYpNrPA/r40XVSQG/rjyJBIgP36QuEUqafex0ug/PiQ77m/mcAs+pa9wr1I9aAxD3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971251;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BEUny82WaebVlZjErr3gkK2eLdZuIEnFQe8TTGmpp8Y=;
	b=A7lsve86WGDcu/L0XOE5K/9Rjr1HVKywMaiQwxtGO7U117pjhML23twzK/HtyU5NOtEa
	 m6RJZ2phsn2umqnX8yjT1Z0KRCYjpvD41dacg/67IA6gteY6Vr17TviHLsIY35HXL09s3
	 Jg9vDj7l0nUnOzH5t3x1hHfEwjhKCNMIZ0qWDWH27RQoSfYORHB1MJd2AMgliy62kSmeT
	 /cDx1AUuish7oG4HNpkc8GvKvp2onoSS8xXAbTAWOE8bVb+8HtZKQwDSB93KwaHVFNmq/
	 6e59DyYkOUBq3GMs/yCUGfALPMEr7g+iuKgdZ9ddZ3XOLlyY67oFo7DtcxXooagEnOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W3v/uofd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B36606A32D;
	Fri,  6 Nov 2026 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3v/uofd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E021F008BE;
	Fri,  6 Nov 2026 13:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971251;
	bh=BEUny82WaebVlZjErr3gkK2eLdZuIEnFQe8TTGmpp8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W3v/uofdpNR2Rk+ti3k3eLhwRl8qd3j/o3UpdCLw1r9bDWcWDV9Q2g2Mctxn202D8
	 c/FBOjy84Dr3TC1x0aJUXFdndbEwaROQOBgDxizFNhn+KYbZHb+M0Av3krrQXaS7VT
	 R/ziTQDqCjE8qRdXCBNMBGw7xW3bXn9x+ov/QYb/wePL78AyaQlEzFFddP+IPORzC+
	 Z7wQvvoyip98+sKWCTscmYUh7GhZ2aiQ7HSuK+43DVQmKhSKlXlHVoqoGUfX9xUO1a
	 j9am0ajUbjwYIVR9gEElaaWz66kVA/IQLaSoq/A1jZ78y1d9bP9RgfanwikPtbey8k
	 0uZBY+8gKrwXQ==
Date: Fri, 6 Nov 2026 14:20:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Benjamin LaHaise <bcrl@kvack.org>, Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-aio@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] aio: don't let exit_aio() return before complete() is
 done
Message-ID: <20261106-leibhaftig-zwang-kopftuch-73155b9bff76@brauner>
References: <20261030-work-aio-exit_aio-v1-1-83942022a4c4@kernel.org>
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
In-Reply-To: <20261030-work-aio-exit_aio-v1-1-83942022a4c4@kernel.org>

Oh, hm. I think we got our wires crossed. This is fixed upstream but I
took my own patch. I didn't realize you had sent one. Sorry about that.
