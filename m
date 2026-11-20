Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795142332;
	b=LnfNbwlLU3mAMP7wUEU/pBojrg1ad6nnD0KKufmzxAkU24dy78DSeWaaU5CpoMjvs4k6
	 0bQ2zTSJdrTF7JbO4PLGIHmois1Se+HSvTsO+lBIQ3pEV+G+leXfiEysq6j6FO19pd4vN
	 JW4ioQbV6AMThYyeVSnHGtVauPKjLdh4TjjI53Jed7VnQ+gp79TirD5qdO9+qWWwxrGmK
	 5k8zeCEqloQRoYgrNt6q9FNAu/gZ3U9iH0EYm2uAyfUwVAgJT3xlJJnPFhcFS+19yYqt6
	 iqHVSILbhFl9R3EuTw7vIE9pYGp17gCccMqDJ0glrimy73yHtEKU4FghfM8b8JhdCLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795142332;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=29z+M4K+nMraY2Z3/kC+/4i2WSpHZgoWl+NGzdmeJyo=;
	b=IHcaiWQ2zsZhV0QZ8a0QaLbsoXjXnkOJ/fqdtpmWrroke3yNXIlKdtdoGqe9De9Ot4Cf
	 ISi7GxLzvsMkTJQVwbvtk6QyR8TLPaLXQ2aS27GZu4Fan3uRIp0gilIKmRiFCi259cbJd
	 90phPVGTeWmcLmyaXALVv4s0/gG+9kUx/jcouzhV0ZQBVCONvn9boOo8OFaK/AsiIBQpV
	 GJqviG7tUlwSMiKHT6XZV0iCBQJfRgZLpNEAxM+B7IAXe37bH20hcJYEjZABpAJJWFo0f
	 CBLbUZz5fTawDmrI9t516cCt0/FGieu+Iq+QnrUO3llKnXe4nkNEh5rTiF/IEbRiiJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWWPym8I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111FB606A320;
	Fri, 20 Nov 2026 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWWPym8I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1F01F000CA;
	Fri, 20 Nov 2026 02:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795142331;
	bh=29z+M4K+nMraY2Z3/kC+/4i2WSpHZgoWl+NGzdmeJyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lWWPym8Ind1IdLXiO0+2FBaPScq4T8Nez55D6ZLpZE+PGU6F9zFksDNX+IPrN2bLF
	 RjimWO+riNhJ+3bJyPLw1TiUxfUVGmwSQOYLwjhVGiqju/cUMRccd5jhhcw98XvsU4
	 hkrd3jqibi22YpDQxBhF2izUcQJNwjSgApLcAdprx0T7M7j6f0kpbUyDOyO9ihN2SS
	 MKyHHgOx41huVgpKbYOeZ2kbe8BS02mzGG9ORupVgqnob/W2YkKJSnMiPZlBRFvG7i
	 8UPEkyoE8UN29gQbxtcN87TWekKsUTfELKv4mXNGiETScqwLiMJTZwWg6OVvIQczDP
	 DeWbnkH7d+jGw==
Date: Fri, 20 Nov 2026 02:38:48 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: wilco_ec: Reject out-of-bounds property
 length
Message-ID: <av-yuLW0UUcQMDZu@google.com>
References: <20261118101555.3467162-1-maoyixie.tju@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118101555.3467162-1-maoyixie.tju@gmail.com>

On Wed, Nov 18, 2026 at 06:15:55PM +0800, Maoyi Xie wrote:
> wilco_ec_get_property() copies rs.length bytes from rs.data into
> prop_msg->data without checking rs.length, which comes from the EC.
> Both buffers hold WILCO_EC_PROPERTY_MAX_SIZE (4) bytes, so a larger
> length reads past rs on the stack and writes past the caller's message.
> 
> Return -EBADMSG for such a length, as the file does for other bad
> responses.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: wilco_ec: Reject out-of-bounds property length
      commit: 1491040b5f396b23021f2905d18599e2e0bd5908

Thanks!
