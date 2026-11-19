Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084710;
	b=IzTamkNSAl2iECi/S4Ul56EqXDm43vMRngnD5mxEFgw4aOdb+H1RW/COkjLZLDqZxxm5
	 4d/16HEJUjGhFYXSNvwd5tdsvPw761kh1vOq7RBExnnHJIfVBm7xiKlk0qac5gasqjoFy
	 p5DK5wFVAn2xxdYU3cH0LW9o41GFWw9VXCE68GO9gpo82fin7BfHyEXxj6SFBN5wJzxB3
	 A8SLIFfRND3jdoOUpfu0kydDzVEWT9/iqCJCxGLkSB3PnO6115iwF0WBPTyeNC8Q9JB9U
	 UZEUhq+wKRoBILuV+gMaAzxm7W1sLXfuLJhbnqFq/e++Aat948HYbxQ9dU+NaoHgaxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084710;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kHeHrkVo20OQlVn8aupesKp24dbwdWxbH7wFLkk+cRg=;
	b=yUjNpcIJi5DTtNecGkFXWPMamdCvZRy35B90NQJQ2eEHVbTlqb+XyOjxvHCLaXdqL6Mv
	 kngkYqctVyr9f/u/pa3OgIu6h3iHa7ouagu05hfx+XxkqCcr5173cJrZC/UGYCm/WZfVn
	 QaE5pNPSs+X80fcoWt/n543gahYQw811WSeNcT67VArUuUPVKvvUCO5AdoruYbApvdago
	 xhqSXTfTBMhToln0dsCX3Uw3P0sAVVUQ8jNv2uBE0ZYoshwTTz1xFuM78wmpTcr5sCvhK
	 CT+fqiLk5e6xwSwYeAhzDHMLRTced8HlaeN2yTh365QgN2P0+UV6jAa+oB12BIj28FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F30581Ga;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1D484606A324;
	Thu, 19 Nov 2026 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F30581Ga
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F22071F000C4;
	Thu, 19 Nov 2026 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795084709;
	bh=kHeHrkVo20OQlVn8aupesKp24dbwdWxbH7wFLkk+cRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F30581Gah+Nnu/lHUNmM+YocHXjOdtAumCbf804a2kSOqA+4gEsbtwfWbVUJ11wBQ
	 Of6ZTFxwnX4hk+NCl8izeDDTjHKK7h3J+prTV+x1XRtT4WlrWtR50qf1Yb+xkQ3c+i
	 d84tAy0IJH/GqqZZ+lEk2yYVJoh39P4TJGlfwyjjmVK5t1CvcAeC+xfM0BsEi9FKrq
	 jGdtN+rW8bZ2QTbSrPp9+lVALudtExdlCts+hML8C1hyUi8lRHTh+LOJxwGnoVIqhb
	 IGMg5j1Erj+oLm57TKlwCGEIxjlpf4GAEM1Yktpf3JKJUVdrVd8+/ouFywnNhycktD
	 hLQzVi+uEAWKA==
Date: Thu, 19 Nov 2026 11:38:26 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: brendan.higgins@linux.dev, david@davidgow.net, raemoar63@gmail.com, 
	sboyd@kernel.org, skhan@linuxfoundation.org, logang@deltatee.com, 
	gregkh@linuxfoundation.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, 13667453960@163.com, stable@vger.kernel.org
Subject: Re: [PATCH] kunit: fix resource leak when init fails
Message-ID: <cupe5w2gyy5gcnviabvrel42llyrzzul5fl6fzwcz7w56zfpmd@ekgoru6l3ujz>
References: <20261118093857.578044-1-yijiangshan@kylinos.cn>
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
In-Reply-To: <20261118093857.578044-1-yijiangshan@kylinos.cn>

On Wed, Nov 18, 2026 at 05:38:57PM +0800, Jiangshan Yi wrote:
> If the init function passed to kunit_alloc_resource() or
> kunit_alloc_and_get_resource() fails, __kunit_add_resource() returns
> before the resource is added to the test's resource list, so the
> allocated resource is never freed. Call kfree() on the error path.
> 
> The free function is not called on this path: init() is responsible for
> cleaning up after a failure, and free() expects an initialized resource.
> 
> Fixes: 0a756853586c ("kunit: test: add test resource management API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
