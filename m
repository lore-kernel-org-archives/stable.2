Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1E4349B7;
	Sun, 27 Sep 2026 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534503; cv=none; b=GJJ1Oy/ZriWdRxq5G+RRaFyLizFcyHvCU0maJABUg2J9aef6mPSfP0p/8CGqYqbN8Z564k60kVkTMmbYE7fC5mL8GkzBhWfolXV2WGIAVUc3Qn7Dczbxb5NLa/g7QOMt6ZPG6gp/iBCSDVzeQXM6zSBvaunuxwHvNrNU9uuJ4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534503; c=relaxed/simple;
	bh=k4I7MRIunrIT0WH7njl5453uxDs9erHh4Cg1J7TeQ6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgliFsgT9VbHOUM48gX0rI++JIq5QT9S+eK2WRVJjlTsm50SjZ3EN55ojjKm8mQ3rgh/9cW0DhohV2pPfop8XbeVHt9jTrSP560KE8ZQjEU8nIAgfn66+ELmhJtYcqhfEMxEfg/SBKox9+U9gsWrdG1Uf357AsbHWH27rRRFTgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVZDrpJ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVZDrpJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096881F000FF;
	Sun, 27 Sep 2026 18:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790534501;
	bh=q1wveTXlrcNfAMuAl2ahauCnwLttneDeFn6RjHqrleo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CVZDrpJ4ZqhD8BvFZvcaX7B8YZJ/n5kdN2YtIGPjaXLgqdc57EwcF8leLxH7XDrzc
	 so8488rFpEY5s5JCpQbF+0VltENYl7NW1v3zgo4e9coyPXjko/J49W4IawpoV5UOvx
	 vJdeztMcI9PFuqzcxQWQKUMYENZ9XJtwoh/yjYWhDgvqyFJMHpesBa2kny9XSFO7bu
	 5lwFXBiyyUZKnPXJVbFeE/E9lR5RWsXizeATnhQqq7wD8IK6kgjFLh4llIri7MLHS+
	 zccEwSUN7HNSimQra0W8h2PAeB5LqzyFnGPCSjuMtaUkiCZ3r8J+cve9dY4TWn8yI2
	 lzHOthAXQLmrQ==
Date: Sun, 27 Sep 2026 19:41:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <sashiko-bot@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v8 0/5] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Message-ID: <20260927194135.1282f30a@jic23-hlaptop>
In-Reply-To: <20260924-mcp47feb02_refactor-v8-0-17dc2ce3485e@microchip.com>
References: <20260924-mcp47feb02_refactor-v8-0-17dc2ce3485e@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 15:59:18 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Refactor I2C driver implementation into separate modules in order to add
> support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C
> implementation. The I2C and SPI devices have the same memory map and
> supported functionalities.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Applied with the Reported-by that Joshua called out and that
power modes array visibility change dropped.  

Applied to the testing branch of iio.git.  After that has been
poked a bit by 0-day I'll push it out as togreg and it will be
lined up for the coming merge window.

Thanks,

Jonathan

> ---
> Changes in v8:
> - create a new precursor patch for moving mutex in store_eeprom_store()
> - add property present check for label before reading
> - use EXPORT_NS_SIMPLE_DEV_PM_OPS() instead of EXPORT_SIMPLE_DEV_PM_OPS()
> - base this version on testing branch in order to send just remaining
>    patches to be accepted
> - Link to v7: https://lore.kernel.org/r/20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com
> 
> Changes in v7:
> - replace custom mask define with standard field_prep()
> - use "Suggested-by" instead of "Reported-by" where it was more suitable
> - use "Fixes:" with "Closes:" instead of "Link:" for fixes tags in commit
>    messages
> - modified module description for core when adding support for SPI parts
>    in order to specify SPI families too
> - remove unused macro MCP47FEB02_GAIN_BIT_MASK from the second commit
> - Link to v6: https://lore.kernel.org/r/20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com
> 
> Changes in v6:
> - use field_get() in Gain, Vref and Power-Down registers channel formulas
> - rebase from 7.2 to 7.3-rc1
> - add fixes tags and Cc stable in the commit messages
> - add numeric constants in front of time defines for better readability
> - replaced dev_err() with dev_warn_probe() for missing label
> - if match data is not found at probe, return -ENODATA and a suitable
>     error message
> - Link to v5: https://lore.kernel.org/r/20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com
> 
> Changes in v5:
> - improve commit messages by justifying the changes made
> - increase polling time for EEPROM writes
> - delete unnecessary comments and extra blank line from header file
> - Link to v4: https://lore.kernel.org/r/20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com
> 
> Changes in v4:
> - remove unused headers
> - add missing header types.h in protocol files
> - create 6 precursor commits before the refactor patch for handling:
>     - comment typo
>     - renaming command mask define
>     - for an invalid label use a debug message instead of probe error
>     - correct return value in store_eeprom_store() for false state case
>     - correct channel gain formula
>     - read DAC value register to initialize channel data struct field at
>       probe
> - Link to v3: https://lore.kernel.org/r/20260804-mcp47feb02_refactor-v3-0-97f8b81f3628@microchip.com
> 
> Changes in v3:
> - renumbering the patch version to include the first patch submision
> - fix review comments device tree binding:
>    - change 'additionalProperties' to unevaluatedProperties
>    - add else branch with spi-max-frequency in the condition which checks
>      if a device has SPI interface
>    - correct SPI address example
>    - add clock polarity and clock phase properties for SPI devices
>    - enumerate I2C devices in lexicographic order from the description section
>    - specify supported SPI modes using dependencies
> - fix review comments driver:
>    - remove unneccesarry libraries and add the missing ones
>    - correct comment typo
>    - return -ENODEV using dev_err_probe() in protocol probe functions
>    - use named initializers
>    - move defines for registers and enums from the header to the core file
>    - add dev_set_drvdata() in probe()
>    - move mutex aquiring from mcp47feb02_write_to_eeprom() to
>      store_eeprom_store()
>    - write correct value into Vref register in resume()
> - Link to v2: https://lore.kernel.org/r/20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com
> 
> Changes in v2:
> - include in the same patch series the refactoring of the driver and the
>   support for SPI devices, but in different patches
> - remove changes regarding review comments received not related to the
>   code refactoring
> - first version of the combined refactoring I2C and adding support for SPI
>   driver
> - Link to v1: https://lore.kernel.org/all/20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com
> 
> v1:
> - first version which did not separate the refactoring and adding support for
>   SPI devices (into different patches from the same series)
> 
> ---
> Ariana Lazar (5):
>       iio: dac: mcp47feb02: Avoid unjustified probe error on missing label
>       iio: dac: mcp47feb02: protect EEPROM store sequence with mutex
>       iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver into two modules
>       dt-bindings: iio: dac: add support for MCP48FEB02 SPI
>       iio: dac: add support for Microchip MCP48FEB02
> 
>  .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 221 ++++++++++---
>  MAINTAINERS                                        |   2 +-
>  drivers/iio/dac/Kconfig                            |  32 +-
>  drivers/iio/dac/Makefile                           |   4 +-
>  .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 342 ++-------------------
>  drivers/iio/dac/mcp47feb02-i2c.c                   | 145 +++++++++
>  drivers/iio/dac/mcp47feb02-spi.c                   | 145 +++++++++
>  drivers/iio/dac/mcp47feb02.h                       |  43 +++
>  8 files changed, 573 insertions(+), 361 deletions(-)
> ---
> base-commit: 81e043887112f846f88ef9ef20c744b5c815de57
> change-id: 20260625-mcp47feb02_refactor-fa8420ae3282
> 
> Best regards,

