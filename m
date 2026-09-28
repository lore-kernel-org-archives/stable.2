Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689B3859D4;
	Mon, 28 Sep 2026 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620021; cv=none; b=tdTfCD2fEs66hPA/94lp/5MqfEcxM62NEZQqkEndQjujAx3FJyEfZ8+nlULpvxkxHxwJYfmb7LqmUxrtYd0LpwQIDBhOO96ZCupeua9PbyV6mw09pE1l+V5pf+8hM4/fMe1ySPJegZS/CA010CYwT+GX+tyjb1wUJcB0HFR52G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620021; c=relaxed/simple;
	bh=A0ssjJSHEKjFlY7vJ1uT8qNAnt8roHHxq1uRpcA6jLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBK1/6Y4RvyNL9/iOML6/WT6HfC+gcn3Y8l0WeUirof9ck4PmM6huzIiin5dn99CJs/eZ/1mASX8UPk4qi6FeN3JQcUBhYaYbrBHkfMYOZyJaVhp9ZcpW8cMhTl0AMk8tZEELBC8RuYj6zWLn7uGA0/Zz6k8cH4s6WkVXm+IhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chb2sgtz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chb2sgtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2B81F000FF;
	Mon, 28 Sep 2026 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620019;
	bh=5VWumWvvkifyy6k7ULM1njiBaWO9+JRGvzCFB/mqVVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=chb2sgtzjjHiteg5Fn4N+gSYrHJGxly+hk6ZPdC/1GDZUnodh9BHgTV0hmYCq7pjy
	 01dngRTC78Y4R9xQjHGHhmcNr46422wdeNxUkq9BJe+pZuc18YVYQsz/1Kj+w0nWD4
	 i1BD+BJxj9Ux70rJ5CoJxXA8egSa1bPPObjZ3znEbFxKrRoGTvwcgUdg1ZxS1mGOGd
	 l+YufaubCOz/RkKgU3BSi0lAKjh8FJfY94smu9byGSPG7HJiwPT/ZVCgG9ZYztvYqL
	 4F1k5Kvjhh4vj/49RRCqEE/xZdN6vNuqsuzvkS3vjpVwcJVmeJPjstruv/aWGPzLWl
	 zp7FgwfQ9f5Rw==
Date: Mon, 28 Sep 2026 13:26:58 -0500
From: Rob Herring <robh@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Saravana Kannan <saravanak@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko AI <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] of/overlay: don't pass the changeset's own id to
 of_overlay_remove()
Message-ID: <20260928182658.GA185307-robh@kernel.org>
References: <20260917-b4-of-overlay-remove-all-fix-v1-1-920441cecae2@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-of-overlay-remove-all-fix-v1-1-920441cecae2@nexthop.ai>

On Thu, Sep 17, 2026 at 07:28:16PM -0700, Abdurrahman Hussain wrote:
> of_overlay_remove_all() passes &ovcs->id to of_overlay_remove(), which
> zeroes *ovcs_id once the changeset is reverted, before calling
> free_overlay_changeset(). Through the aliased pointer that zeroes
> ovcs->id itself, so free_overlay_changeset()'s "ovcs->id > 0" guard
> is false and both idr_remove() and list_del() are skipped: the
> overlay_changeset is kfree()d while still linked in ovcs_list and
> registered in ovcs_idr.
> 
> Every overlay removed through of_overlay_remove_all() thus leaves a
> dangling list node and idr entry behind. The next ovcs_list iteration
> or idr lookup walks freed memory, and the ids are never returned to
> the idr. Nothing in-tree calls of_overlay_remove_all() today, but it
> is the documented API for removing every overlay in one go
> (Documentation/devicetree/overlay-notes.rst), so any module user hits
> this deterministically.
> 
> Pass a local copy of the id, like every other of_overlay_remove()
> caller does.

If every caller passes a local and updating the value is not needed, 
then we should just update the API to pass the value rather than a 
reference.

Additionally, if there are no callers we should perhaps just remove the 
API.

Rob
