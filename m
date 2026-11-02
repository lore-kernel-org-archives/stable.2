Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637252;
	b=zx5yrIvtELrPQIhlnL8hfvcxQFQ4lNk/7swQPHg713XHeMpMRvwk+r8rXA0Pv6yasIfD
	 G8fflxxtoJF1G3+L+Jz9Mn8e/MLrLXtau6UkqKX1m9j0NuRAiHnB0Mu2fZuvV5ATALl9B
	 xCK4Y9uzPbKICkvSoRwF3RX5twt7iezgmb5gdX89IoHosAdwNLbOs29WLm3zjXeg35vtJ
	 jcaE8LQw7JfRjUosxy9dFumE4Otvz97KfrOhxnefgXQ2U6uTzHB1+n8x+3AoPhHEsZBIp
	 7GagI1rJGT42ZA8BuP4G7rNrTnY2wccQuM2S3jVlt0vH0nadOO7HKIGlJSeM7pLthzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637252;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0CpT09PC5F6pB7skis+Onxs/yao89zfdFKF29z0BxN0=;
	b=zAX2f8BD+uTUhHCBmv8kMBrzSjBQKIDLkwyWFhFA1Khvk7R/lvU69tZ1K0cNUPO7Pz3a
	 GCB3tBjbPGnA1cnOcbFi8w0j84EA108Cks0CHmBzQ4kneP7QOwpo3GgMyIinkcoqxyCc9
	 r5ia00trHB+GjYjOVu10ywNztq4LZVctHDcgx7UKIULpgWcyB+EYVKfPCY9M1dmE2h9MF
	 rY58vEg0LdCgqResWUsG0o3aVmRWAb5v4sx55Gq1YBa0/qs9qQjstIjH52NyEkXtINECn
	 3iILXaxGOKBZq+R47O4m+ly4oBGe9gj3GCgqYFSo/D4qNHxqsVoS8pgwtSuYCNsp9dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2uI76ow;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F48608B07C;
	Mon,  2 Nov 2026 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2uI76ow
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5421F00A17;
	Mon,  2 Nov 2026 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793637251;
	bh=0CpT09PC5F6pB7skis+Onxs/yao89zfdFKF29z0BxN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K2uI76owYq6F9R7pPNar1nwD1RKouk4pkic0kdWIowSFoMhnTK7kW9E6kaOk/Lu5i
	 BF+5SEbEwWJHzifBAv/Wwy5nTmD2LcDkjin9xTUXmESnFDWG17CmG+Cp68tLL4hN9Q
	 47Jot2fA9X7mQT1pad2Y/zx6fwqwWsmNi1Y7C+bZtQO5k5O92+C8OCXv1dQmJ3PI6a
	 4g/hUbjAxjLqeiYPtwNsjZRqD0zifrsqaPJGNGl+n4AivuyxL/D4q3hZy/uB4K4UP3
	 cCijpp1vh7TP9/zozMtKm4TdLZ3gSraeR2ryaKGGo0zKLTlh23RBaIHOUU9cOTc0pO
	 E6Ybitr407Jqg==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xNuz3-00000005fhp-0L7X;
	Mon, 02 Nov 2026 17:34:09 +0100
Date: Mon, 2 Nov 2026 17:34:09 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] software node: fix primary software node removal
Message-ID: <aui7gUuJ4zMVM8gF@hovoldconsulting.com>
References: <20261102111420.1330760-1-johan@kernel.org>
 <20261102111420.1330760-3-johan@kernel.org>
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
In-Reply-To: <20261102111420.1330760-3-johan@kernel.org>

On Mon, Nov 02, 2026 at 12:14:20PM +0100, Johan Hovold wrote:
> When removing a software node using device_remove_software_node(), the
> primary fwnode pointer is never cleared if the software node is the
> primary node.
> 
> Since commit 7d80509ff0da ("driver core: platform: unify release path")
> this can lead to a use-after-free when freeing a platform device if a
> driver or subsystem (e.g. mfd) has already removed and freed the node.
> 
> Clear the primary fwnode pointer when removing a software node that is
> the primary node to avoid this.
> 
> Fixes: 7d80509ff0da ("driver core: platform: unify release path")
> Cc: stable@vger.kernel.org	# 7.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko had some comments on this one, will revisit.

The first patch could go in meanwhile.

Johan
